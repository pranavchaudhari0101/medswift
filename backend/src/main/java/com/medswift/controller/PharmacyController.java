package com.medswift.controller;

import com.medswift.dto.ApiResponse;
import com.medswift.dto.PharmacyDto;
import com.medswift.service.PharmacyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/pharmacies")
@Tag(name = "Pharmacies", description = "Pharmacy search and details")
public class PharmacyController {

    private final PharmacyService pharmacyService;

    public PharmacyController(PharmacyService pharmacyService) {
        this.pharmacyService = pharmacyService;
    }

    @GetMapping
    @Operation(summary = "Get pharmacies, optionally filtered by city and location")
    public ResponseEntity<ApiResponse.Success<List<PharmacyDto.PharmacyResponse>>> getPharmacies(
            @RequestParam(required = false) String city,
            @RequestParam(required = false) Double lat,
            @RequestParam(required = false) Double lng) {
        return ResponseEntity.ok(ApiResponse.Success.<List<PharmacyDto.PharmacyResponse>>builder()
                .data(pharmacyService.getPharmacies(city, lat, lng))
                .build());
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get pharmacy by ID")
    public ResponseEntity<ApiResponse.Success<PharmacyDto.PharmacyResponse>> getPharmacy(
            @PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.Success.<PharmacyDto.PharmacyResponse>builder()
                .data(pharmacyService.getPharmacyById(id))
                .build());
    }
}
