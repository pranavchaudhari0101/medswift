package com.medswift.service;

import com.medswift.dto.PharmacyDto;
import com.medswift.exception.ResourceNotFoundException;
import com.medswift.model.Pharmacy;
import com.medswift.repository.PharmacyRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PharmacyService {

    private final PharmacyRepository pharmacyRepository;

    public PharmacyService(PharmacyRepository pharmacyRepository) {
        this.pharmacyRepository = pharmacyRepository;
    }

    public List<PharmacyDto.PharmacyResponse> getPharmacies(String city, Double lat, Double lng) {
        List<Pharmacy> pharmacies;

        if (city != null && !city.isBlank()) {
            pharmacies = pharmacyRepository.findActivePharmaciesInCity(city);
        } else {
            pharmacies = pharmacyRepository.findByIsActiveTrue();
        }

        return pharmacies.stream()
                .map(p -> {
                    PharmacyDto.PharmacyResponse response = mapToResponse(p);
                    if (lat != null && lng != null) {
                        response.setDistance(calculateDistance(lat, lng, p.getLatitude(), p.getLongitude()));
                    }
                    return response;
                })
                .sorted((a, b) -> {
                    if (a.getDistance() != null && b.getDistance() != null) {
                        return Double.compare(a.getDistance(), b.getDistance());
                    }
                    return Double.compare(b.getRating(), a.getRating());
                })
                .collect(Collectors.toList());
    }

    public PharmacyDto.PharmacyResponse getPharmacyById(Long id) {
        Pharmacy pharmacy = pharmacyRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Pharmacy not found"));
        return mapToResponse(pharmacy);
    }

    private double calculateDistance(double lat1, double lng1, Double lat2, Double lng2) {
        if (lat2 == null || lng2 == null)
            return 999.0;
        final int R = 6371;
        double dLat = Math.toRadians(lat2 - lat1);
        double dLng = Math.toRadians(lng2 - lng1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                        * Math.sin(dLng / 2) * Math.sin(dLng / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return Math.round(R * c * 10.0) / 10.0;
    }

    private PharmacyDto.PharmacyResponse mapToResponse(Pharmacy pharmacy) {
        return PharmacyDto.PharmacyResponse.builder()
                .id(pharmacy.getId())
                .name(pharmacy.getName())
                .licenseNumber(pharmacy.getLicenseNumber())
                .address(pharmacy.getAddress())
                .city(pharmacy.getCity())
                .latitude(pharmacy.getLatitude())
                .longitude(pharmacy.getLongitude())
                .rating(pharmacy.getRating())
                .totalRatings(pharmacy.getTotalRatings())
                .isVerified(pharmacy.isVerified())
                .operatingHours(pharmacy.getOperatingHours())
                .is24Hours(pharmacy.isIs24Hours())
                .phoneNumber(pharmacy.getPhoneNumber())
                .imageUrl(pharmacy.getImageUrl())
                .build();
    }
}
