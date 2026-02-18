package com.medswift.controller;

import com.medswift.dto.ApiResponse;
import com.medswift.dto.MedicineDto;
import com.medswift.service.MedicineService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/medicines")
@Tag(name = "Medicines", description = "Medicine search and information")
public class MedicineController {

        private final MedicineService medicineService;

        public MedicineController(MedicineService medicineService) {
                this.medicineService = medicineService;
        }

        @GetMapping
        @Operation(summary = "Search medicines by name, generic name, or composition")
        public ResponseEntity<ApiResponse.PagedResponse<List<MedicineDto.MedicineResponse>>> searchMedicines(
                        @RequestParam(required = false) String query,
                        @RequestParam(defaultValue = "0") int page,
                        @RequestParam(defaultValue = "20") int size,
                        @RequestParam(defaultValue = "name") String sortBy) {
                Page<MedicineDto.MedicineResponse> result = medicineService.searchMedicines(
                                query, PageRequest.of(page, size, Sort.by(sortBy)));

                return ResponseEntity.ok(ApiResponse.PagedResponse.<List<MedicineDto.MedicineResponse>>builder()
                                .data(result.getContent())
                                .page(result.getNumber())
                                .size(result.getSize())
                                .totalElements(result.getTotalElements())
                                .totalPages(result.getTotalPages())
                                .build());
        }

        @GetMapping("/{id}")
        @Operation(summary = "Get medicine details by ID")
        public ResponseEntity<ApiResponse.Success<MedicineDto.MedicineResponse>> getMedicine(
                        @PathVariable Long id) {
                return ResponseEntity.ok(ApiResponse.Success.<MedicineDto.MedicineResponse>builder()
                                .data(medicineService.getMedicineById(id))
                                .build());
        }

        @GetMapping("/{id}/alternatives")
        @Operation(summary = "Get generic alternatives for a medicine")
        public ResponseEntity<ApiResponse.Success<List<MedicineDto.MedicineResponse>>> getAlternatives(
                        @PathVariable Long id) {
                return ResponseEntity.ok(ApiResponse.Success.<List<MedicineDto.MedicineResponse>>builder()
                                .data(medicineService.getAlternatives(id))
                                .build());
        }

        @GetMapping("/{id}/pharmacies")
        @Operation(summary = "Compare prices across pharmacies for a medicine")
        public ResponseEntity<ApiResponse.Success<List<MedicineDto.PriceComparison>>> getPriceComparison(
                        @PathVariable Long id) {
                return ResponseEntity.ok(ApiResponse.Success.<List<MedicineDto.PriceComparison>>builder()
                                .data(medicineService.getPriceComparison(id))
                                .build());
        }
}
