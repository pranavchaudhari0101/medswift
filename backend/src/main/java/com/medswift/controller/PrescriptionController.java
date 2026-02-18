package com.medswift.controller;

import com.medswift.dto.ApiResponse;
import com.medswift.exception.ResourceNotFoundException;
import com.medswift.model.Prescription;
import com.medswift.model.User;
import com.medswift.repository.PrescriptionRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/prescriptions")
@Tag(name = "Prescriptions", description = "Prescription upload and management")
public class PrescriptionController {

        private final PrescriptionRepository prescriptionRepository;

        public PrescriptionController(PrescriptionRepository prescriptionRepository) {
                this.prescriptionRepository = prescriptionRepository;
        }

        @PostMapping
        @Operation(summary = "Upload a prescription (stubbed — accepts metadata, not multipart yet)")
        public ResponseEntity<ApiResponse.Success<Map<String, Object>>> uploadPrescription(
                        @AuthenticationPrincipal User user,
                        @RequestParam(required = false) String doctorName,
                        @RequestParam(required = false) String hospitalName) {

                Prescription prescription = Prescription.builder()
                                .user(user)
                                .imageUrl("https://storage.medswift.in/prescriptions/stub_" + System.currentTimeMillis()
                                                + ".jpg")
                                .doctorName(doctorName)
                                .hospitalName(hospitalName)
                                .prescriptionDate(LocalDate.now())
                                .expiryDate(LocalDate.now().plusMonths(6))
                                .verificationStatus(Prescription.VerificationStatus.PENDING)
                                .createdAt(LocalDateTime.now())
                                .build();

                prescription = prescriptionRepository.save(prescription);

                Map<String, Object> data = new HashMap<>();
                data.put("id", prescription.getId());
                data.put("imageUrl", prescription.getImageUrl());
                data.put("verificationStatus", prescription.getVerificationStatus().name());
                data.put("message", "Prescription uploaded. Verification pending.");

                return ResponseEntity.status(HttpStatus.CREATED)
                                .body(ApiResponse.Success.<Map<String, Object>>builder()
                                                .message("Prescription uploaded successfully")
                                                .data(data)
                                                .build());
        }

        @GetMapping
        @Operation(summary = "Get user's prescription history")
        public ResponseEntity<ApiResponse.Success<List<Map<String, Object>>>> getPrescriptions(
                        @AuthenticationPrincipal User user) {
                List<Map<String, Object>> prescriptions = prescriptionRepository
                                .findByUserIdOrderByCreatedAtDesc(user.getId())
                                .stream()
                                .map(p -> {
                                        Map<String, Object> map = new HashMap<>();
                                        map.put("id", p.getId());
                                        map.put("imageUrl", p.getImageUrl());
                                        map.put("doctorName", p.getDoctorName());
                                        map.put("hospitalName", p.getHospitalName());
                                        map.put("prescriptionDate", p.getPrescriptionDate());
                                        map.put("expiryDate", p.getExpiryDate());
                                        map.put("verificationStatus", p.getVerificationStatus().name());
                                        map.put("createdAt", p.getCreatedAt());
                                        return map;
                                })
                                .collect(Collectors.toList());

                return ResponseEntity.ok(ApiResponse.Success.<List<Map<String, Object>>>builder()
                                .data(prescriptions)
                                .build());
        }

        @GetMapping("/{id}")
        @Operation(summary = "Get prescription details")
        public ResponseEntity<ApiResponse.Success<Map<String, Object>>> getPrescription(
                        @AuthenticationPrincipal User user,
                        @PathVariable Long id) {
                Prescription p = prescriptionRepository.findById(id)
                                .orElseThrow(() -> new ResourceNotFoundException("Prescription not found"));

                Map<String, Object> data = new HashMap<>();
                data.put("id", p.getId());
                data.put("imageUrl", p.getImageUrl());
                data.put("doctorName", p.getDoctorName());
                data.put("hospitalName", p.getHospitalName());
                data.put("prescriptionDate", p.getPrescriptionDate());
                data.put("expiryDate", p.getExpiryDate());
                data.put("verificationStatus", p.getVerificationStatus().name());
                data.put("notes", p.getNotes());
                data.put("createdAt", p.getCreatedAt());

                return ResponseEntity.ok(ApiResponse.Success.<Map<String, Object>>builder()
                                .data(data)
                                .build());
        }
}
