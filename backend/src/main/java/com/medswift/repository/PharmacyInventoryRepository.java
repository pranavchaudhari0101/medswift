package com.medswift.repository;

import com.medswift.model.PharmacyInventory;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface PharmacyInventoryRepository extends JpaRepository<PharmacyInventory, Long> {
    List<PharmacyInventory> findByPharmacyId(Long pharmacyId);
    List<PharmacyInventory> findByMedicineId(Long medicineId);
    List<PharmacyInventory> findByMedicineIdAndInStockTrue(Long medicineId);
    Optional<PharmacyInventory> findByPharmacyIdAndMedicineId(Long pharmacyId, Long medicineId);
}
