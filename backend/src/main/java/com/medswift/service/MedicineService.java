package com.medswift.service;

import com.medswift.dto.MedicineDto;
import com.medswift.exception.ResourceNotFoundException;
import com.medswift.model.Medicine;
import com.medswift.model.PharmacyInventory;
import com.medswift.repository.MedicineRepository;
import com.medswift.repository.PharmacyInventoryRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class MedicineService {

    private final MedicineRepository medicineRepository;
    private final PharmacyInventoryRepository inventoryRepository;

    public MedicineService(MedicineRepository medicineRepository, PharmacyInventoryRepository inventoryRepository) {
        this.medicineRepository = medicineRepository;
        this.inventoryRepository = inventoryRepository;
    }

    public Page<MedicineDto.MedicineResponse> searchMedicines(String query, Pageable pageable) {
        Page<Medicine> medicines;
        if (query != null && !query.isBlank()) {
            medicines = medicineRepository.searchMedicines(query, pageable);
        } else {
            medicines = medicineRepository.findAll(pageable);
        }
        return medicines.map(this::mapToResponse);
    }

    public MedicineDto.MedicineResponse getMedicineById(Long id) {
        Medicine medicine = medicineRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Medicine not found"));
        return mapToResponse(medicine);
    }

    public List<MedicineDto.MedicineResponse> getAlternatives(Long medicineId) {
        Medicine medicine = medicineRepository.findById(medicineId)
                .orElseThrow(() -> new ResourceNotFoundException("Medicine not found"));

        if (medicine.getGenericName() == null)
            return List.of();

        return medicineRepository.findAlternatives(medicine.getGenericName(), medicineId)
                .stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    public List<MedicineDto.PriceComparison> getPriceComparison(Long medicineId) {
        medicineRepository.findById(medicineId)
                .orElseThrow(() -> new ResourceNotFoundException("Medicine not found"));

        return inventoryRepository.findByMedicineIdAndInStockTrue(medicineId)
                .stream()
                .map(inv -> MedicineDto.PriceComparison.builder()
                        .pharmacyId(inv.getPharmacy().getId())
                        .pharmacyName(inv.getPharmacy().getName())
                        .pharmacyAddress(inv.getPharmacy().getAddress())
                        .pharmacyRating(inv.getPharmacy().getRating())
                        .price(inv.getPrice())
                        .inStock(inv.isInStock())
                        .operatingHours(inv.getPharmacy().getOperatingHours())
                        .build())
                .collect(Collectors.toList());
    }

    private MedicineDto.MedicineResponse mapToResponse(Medicine medicine) {
        return MedicineDto.MedicineResponse.builder()
                .id(medicine.getId())
                .name(medicine.getName())
                .genericName(medicine.getGenericName())
                .composition(medicine.getComposition())
                .manufacturer(medicine.getManufacturer())
                .category(medicine.getCategory())
                .requiresPrescription(medicine.isRequiresPrescription())
                .description(medicine.getDescription())
                .sideEffects(medicine.getSideEffects())
                .dosage(medicine.getDosage())
                .mrp(medicine.getMrp())
                .imageUrl(medicine.getImageUrl())
                .type(medicine.getType().name())
                .build();
    }
}
