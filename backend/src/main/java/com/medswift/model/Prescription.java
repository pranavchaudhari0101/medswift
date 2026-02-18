package com.medswift.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "prescriptions")
public class Prescription {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false)
    private String imageUrl;

    private String doctorName;
    private String hospitalName;

    private LocalDate prescriptionDate;
    private LocalDate expiryDate;

    @Column(length = 2000)
    private String notes;

    @Enumerated(EnumType.STRING)
    private VerificationStatus verificationStatus = VerificationStatus.PENDING;

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    public enum VerificationStatus {
        PENDING, VERIFIED, REJECTED
    }

    // Constructors
    public Prescription() {
    }

    public Prescription(Long id, User user, String imageUrl, String doctorName, String hospitalName,
            LocalDate prescriptionDate, LocalDate expiryDate, String notes, VerificationStatus verificationStatus,
            LocalDateTime createdAt) {
        this.id = id;
        this.user = user;
        this.imageUrl = imageUrl;
        this.doctorName = doctorName;
        this.hospitalName = hospitalName;
        this.prescriptionDate = prescriptionDate;
        this.expiryDate = expiryDate;
        this.notes = notes;
        this.verificationStatus = verificationStatus;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getHospitalName() {
        return hospitalName;
    }

    public void setHospitalName(String hospitalName) {
        this.hospitalName = hospitalName;
    }

    public LocalDate getPrescriptionDate() {
        return prescriptionDate;
    }

    public void setPrescriptionDate(LocalDate prescriptionDate) {
        this.prescriptionDate = prescriptionDate;
    }

    public LocalDate getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(LocalDate expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public VerificationStatus getVerificationStatus() {
        return verificationStatus;
    }

    public void setVerificationStatus(VerificationStatus verificationStatus) {
        this.verificationStatus = verificationStatus;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // Builder
    public static PrescriptionBuilder builder() {
        return new PrescriptionBuilder();
    }

    public static class PrescriptionBuilder {
        private Long id;
        private User user;
        private String imageUrl;
        private String doctorName;
        private String hospitalName;
        private LocalDate prescriptionDate;
        private LocalDate expiryDate;
        private String notes;
        private VerificationStatus verificationStatus = VerificationStatus.PENDING;
        private LocalDateTime createdAt = LocalDateTime.now();

        PrescriptionBuilder() {
        }

        public PrescriptionBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public PrescriptionBuilder user(User user) {
            this.user = user;
            return this;
        }

        public PrescriptionBuilder imageUrl(String imageUrl) {
            this.imageUrl = imageUrl;
            return this;
        }

        public PrescriptionBuilder doctorName(String doctorName) {
            this.doctorName = doctorName;
            return this;
        }

        public PrescriptionBuilder hospitalName(String hospitalName) {
            this.hospitalName = hospitalName;
            return this;
        }

        public PrescriptionBuilder prescriptionDate(LocalDate prescriptionDate) {
            this.prescriptionDate = prescriptionDate;
            return this;
        }

        public PrescriptionBuilder expiryDate(LocalDate expiryDate) {
            this.expiryDate = expiryDate;
            return this;
        }

        public PrescriptionBuilder notes(String notes) {
            this.notes = notes;
            return this;
        }

        public PrescriptionBuilder verificationStatus(VerificationStatus verificationStatus) {
            this.verificationStatus = verificationStatus;
            return this;
        }

        public PrescriptionBuilder createdAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public Prescription build() {
            return new Prescription(id, user, imageUrl, doctorName, hospitalName, prescriptionDate, expiryDate, notes,
                    verificationStatus, createdAt);
        }
    }
}
