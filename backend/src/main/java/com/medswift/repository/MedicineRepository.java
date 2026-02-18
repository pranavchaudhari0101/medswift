package com.medswift.repository;

import com.medswift.model.Medicine;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface MedicineRepository extends JpaRepository<Medicine, Long> {

    @Query("SELECT m FROM Medicine m WHERE " +
           "LOWER(m.name) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(m.genericName) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(m.composition) LIKE LOWER(CONCAT('%', :query, '%'))")
    Page<Medicine> searchMedicines(@Param("query") String query, Pageable pageable);

    List<Medicine> findByCategory(String category);

    @Query("SELECT m FROM Medicine m WHERE m.genericName = :genericName AND m.id != :excludeId")
    List<Medicine> findAlternatives(@Param("genericName") String genericName, @Param("excludeId") Long excludeId);

    Page<Medicine> findByRequiresPrescription(boolean requiresPrescription, Pageable pageable);
}
