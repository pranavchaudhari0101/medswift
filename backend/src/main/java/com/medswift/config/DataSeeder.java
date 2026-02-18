package com.medswift.config;

import com.medswift.model.*;
import com.medswift.repository.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;

@Component
public class DataSeeder implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(DataSeeder.class);

    private final MedicineRepository medicineRepository;
    private final PharmacyRepository pharmacyRepository;
    private final PharmacyInventoryRepository inventoryRepository;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public DataSeeder(MedicineRepository medicineRepository, PharmacyRepository pharmacyRepository,
            PharmacyInventoryRepository inventoryRepository, UserRepository userRepository,
            PasswordEncoder passwordEncoder) {
        this.medicineRepository = medicineRepository;
        this.pharmacyRepository = pharmacyRepository;
        this.inventoryRepository = inventoryRepository;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        if (medicineRepository.count() > 0)
            return;
        log.info("Seeding sample data...");

        seedMedicines();
        seedPharmacies();
        seedInventory();
        seedDemoUser();

        log.info("Sample data seeded successfully!");
    }

    private void seedMedicines() {
        List<Medicine> medicines = List.of(
                Medicine.builder().name("Dolo 650").genericName("Paracetamol").composition("Paracetamol 650mg")
                        .manufacturer("Micro Labs").category("Pain & Fever").requiresPrescription(false)
                        .description("Used for fever, headache, and mild to moderate pain relief")
                        .sideEffects("Nausea, allergic reactions (rare)").dosage("1 tablet every 4-6 hours")
                        .mrp(new BigDecimal("30.00")).type(Medicine.MedicineType.ALLOPATHY).build(),

                Medicine.builder().name("Crocin Advance").genericName("Paracetamol").composition("Paracetamol 500mg")
                        .manufacturer("GSK").category("Pain & Fever").requiresPrescription(false)
                        .description("Fast-acting pain and fever relief")
                        .sideEffects("Liver damage with overdose").dosage("1-2 tablets every 4-6 hours")
                        .mrp(new BigDecimal("25.50")).type(Medicine.MedicineType.ALLOPATHY).build(),

                Medicine.builder().name("Azithromycin 500").genericName("Azithromycin")
                        .composition("Azithromycin 500mg")
                        .manufacturer("Cipla").category("Antibiotics").requiresPrescription(true)
                        .description("Antibiotic for bacterial infections")
                        .sideEffects("Diarrhea, nausea, abdominal pain").dosage("1 tablet daily for 3 days")
                        .mrp(new BigDecimal("95.00")).type(Medicine.MedicineType.ALLOPATHY).build(),

                Medicine.builder().name("Metformin 500").genericName("Metformin")
                        .composition("Metformin Hydrochloride 500mg")
                        .manufacturer("USV").category("Diabetes").requiresPrescription(true)
                        .description("Used to manage type 2 diabetes by controlling blood sugar levels")
                        .sideEffects("Nausea, diarrhea, stomach upset").dosage("1 tablet twice daily with meals")
                        .mrp(new BigDecimal("45.00")).type(Medicine.MedicineType.ALLOPATHY).build(),

                Medicine.builder().name("Glycomet GP 2").genericName("Metformin")
                        .composition("Metformin 500mg + Glimepiride 2mg")
                        .manufacturer("USV").category("Diabetes").requiresPrescription(true)
                        .description("Combination medicine for type 2 diabetes")
                        .sideEffects("Hypoglycemia, weight gain").dosage("1 tablet daily with breakfast")
                        .mrp(new BigDecimal("132.00")).type(Medicine.MedicineType.ALLOPATHY).build(),

                Medicine.builder().name("Amlodipine 5").genericName("Amlodipine").composition("Amlodipine Besylate 5mg")
                        .manufacturer("Cipla").category("Blood Pressure").requiresPrescription(true)
                        .description("Calcium channel blocker for high blood pressure")
                        .sideEffects("Swelling in ankles, dizziness").dosage("1 tablet daily")
                        .mrp(new BigDecimal("35.00")).type(Medicine.MedicineType.ALLOPATHY).build(),

                Medicine.builder().name("Telmisartan 40").genericName("Telmisartan").composition("Telmisartan 40mg")
                        .manufacturer("Glenmark").category("Blood Pressure").requiresPrescription(true)
                        .description("ARB class medicine for hypertension")
                        .sideEffects("Dizziness, back pain").dosage("1 tablet daily")
                        .mrp(new BigDecimal("85.00")).type(Medicine.MedicineType.ALLOPATHY).build(),

                Medicine.builder().name("Pantoprazole 40").genericName("Pantoprazole")
                        .composition("Pantoprazole Sodium 40mg")
                        .manufacturer("Sun Pharma").category("Gastro").requiresPrescription(true)
                        .description("Proton pump inhibitor for acid reflux and GERD")
                        .sideEffects("Headache, diarrhea, nausea").dosage("1 tablet daily before breakfast")
                        .mrp(new BigDecimal("65.00")).type(Medicine.MedicineType.ALLOPATHY).build(),

                Medicine.builder().name("Cetirizine 10").genericName("Cetirizine")
                        .composition("Cetirizine Hydrochloride 10mg")
                        .manufacturer("Dr. Reddy's").category("Allergy").requiresPrescription(false)
                        .description("Antihistamine for allergies, hay fever, and hives")
                        .sideEffects("Drowsiness, dry mouth").dosage("1 tablet daily")
                        .mrp(new BigDecimal("18.00")).type(Medicine.MedicineType.ALLOPATHY).build(),

                Medicine.builder().name("Montelukast 10").genericName("Montelukast")
                        .composition("Montelukast Sodium 10mg")
                        .manufacturer("Sun Pharma").category("Respiratory").requiresPrescription(true)
                        .description("Leukotriene receptor antagonist for asthma and allergic rhinitis")
                        .sideEffects("Headache, upper respiratory infection").dosage("1 tablet daily at bedtime")
                        .mrp(new BigDecimal("145.00")).type(Medicine.MedicineType.ALLOPATHY).build(),

                Medicine.builder().name("Vitamin D3 60K").genericName("Cholecalciferol")
                        .composition("Cholecalciferol 60000 IU")
                        .manufacturer("Cadila").category("Vitamins").requiresPrescription(false)
                        .description("High-dose vitamin D supplement for deficiency")
                        .sideEffects("Nausea, constipation (high doses)").dosage("1 sachet weekly for 8 weeks")
                        .mrp(new BigDecimal("110.00")).type(Medicine.MedicineType.ALLOPATHY).build(),

                Medicine.builder().name("ORS Powder").genericName("ORS")
                        .composition("Sodium Chloride + Potassium Chloride + Glucose")
                        .manufacturer("WHO Standard").category("Rehydration").requiresPrescription(false)
                        .description("Oral rehydration salts for dehydration")
                        .sideEffects("None significant").dosage("Dissolve in 1 litre water, sip frequently")
                        .mrp(new BigDecimal("22.00")).type(Medicine.MedicineType.OTC).build());

        medicineRepository.saveAll(medicines);
        log.info("Seeded {} medicines", medicines.size());
    }

    private void seedPharmacies() {
        List<Pharmacy> pharmacies = List.of(
                Pharmacy.builder().name("Apollo Pharmacy - Koramangala").licenseNumber("KA-PH-2024-001")
                        .address("80 Feet Road, Koramangala 4th Block").city("Bangalore").state("Karnataka")
                        .pincode("560034")
                        .latitude(12.9352).longitude(77.6245).rating(4.5).totalRatings(328)
                        .isVerified(true).operatingHours("08:00-23:00").is24Hours(false)
                        .phoneNumber("9876500001").isActive(true).build(),

                Pharmacy.builder().name("MedPlus - Indiranagar").licenseNumber("KA-PH-2024-002")
                        .address("100 Feet Road, Indiranagar").city("Bangalore").state("Karnataka").pincode("560038")
                        .latitude(12.9716).longitude(77.6412).rating(4.2).totalRatings(215)
                        .isVerified(true).operatingHours("09:00-22:00").is24Hours(false)
                        .phoneNumber("9876500002").isActive(true).build(),

                Pharmacy.builder().name("Wellness Forever - HSR Layout").licenseNumber("KA-PH-2024-003")
                        .address("27th Main, HSR Layout Sector 1").city("Bangalore").state("Karnataka")
                        .pincode("560102")
                        .latitude(12.9081).longitude(77.6476).rating(4.7).totalRatings(412)
                        .isVerified(true).operatingHours("00:00-23:59").is24Hours(true)
                        .phoneNumber("9876500003").isActive(true).build(),

                Pharmacy.builder().name("Netmeds Store - Whitefield").licenseNumber("KA-PH-2024-004")
                        .address("ITPL Main Road, Whitefield").city("Bangalore").state("Karnataka").pincode("560066")
                        .latitude(12.9698).longitude(77.7500).rating(4.0).totalRatings(156)
                        .isVerified(true).operatingHours("08:00-21:00").is24Hours(false)
                        .phoneNumber("9876500004").isActive(true).build(),

                Pharmacy.builder().name("HealthKart Pharmacy - Andheri").licenseNumber("MH-PH-2024-001")
                        .address("Lokhandwala Complex, Andheri West").city("Mumbai").state("Maharashtra")
                        .pincode("400053")
                        .latitude(19.1364).longitude(72.8296).rating(4.3).totalRatings(289)
                        .isVerified(true).operatingHours("09:00-23:00").is24Hours(false)
                        .phoneNumber("9876500005").isActive(true).build(),

                Pharmacy.builder().name("PharmEasy Store - Bandra").licenseNumber("MH-PH-2024-002")
                        .address("Hill Road, Bandra West").city("Mumbai").state("Maharashtra").pincode("400050")
                        .latitude(19.0596).longitude(72.8295).rating(4.6).totalRatings(501)
                        .isVerified(true).operatingHours("00:00-23:59").is24Hours(true)
                        .phoneNumber("9876500006").isActive(true).build());

        pharmacyRepository.saveAll(pharmacies);
        log.info("Seeded {} pharmacies", pharmacies.size());
    }

    private void seedInventory() {
        List<Pharmacy> pharmacies = pharmacyRepository.findAll();
        List<Medicine> medicines = medicineRepository.findAll();

        for (Pharmacy pharmacy : pharmacies) {
            for (int i = 0; i < medicines.size(); i++) {
                Medicine medicine = medicines.get(i);
                // Vary prices by pharmacy (±10%)
                double priceVariation = 0.90 + (Math.random() * 0.20);
                BigDecimal price = medicine.getMrp().multiply(BigDecimal.valueOf(priceVariation))
                        .setScale(2, java.math.RoundingMode.HALF_UP);

                // Some items randomly out of stock
                boolean inStock = Math.random() > 0.15;

                PharmacyInventory inventory = PharmacyInventory.builder()
                        .pharmacy(pharmacy)
                        .medicine(medicine)
                        .price(price)
                        .inStock(inStock)
                        .quantity(inStock ? (int) (Math.random() * 100) + 5 : 0)
                        .build();

                inventoryRepository.save(inventory);
            }
        }
        log.info("Seeded inventory for {} pharmacies × {} medicines", pharmacies.size(), medicines.size());
    }

    private void seedDemoUser() {
        if (userRepository.existsByPhone("9999999999"))
            return;

        User demo = User.builder()
                .name("Rajesh Kumar")
                .phone("9999999999")
                .email("rajesh@demo.com")
                .password(passwordEncoder.encode("demo123"))
                .gender(User.Gender.MALE)
                .role(User.Role.USER)
                .build();

        userRepository.save(demo);
        log.info("Seeded demo user: phone=9999999999, password=demo123");
    }
}
