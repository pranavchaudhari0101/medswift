package com.medswift.repository;

import com.medswift.model.Pharmacy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface PharmacyRepository extends JpaRepository<Pharmacy, Long> {

    List<Pharmacy> findByCity(String city);

    List<Pharmacy> findByIsActiveTrue();

    @Query("SELECT p FROM Pharmacy p WHERE p.isActive = true AND p.city = :city")
    List<Pharmacy> findActivePharmaciesInCity(@Param("city") String city);

    List<Pharmacy> findByIs24HoursTrue();
}
