# Product Requirements Document (PRD)
## Prescription Delivery Platform for India

**Document Version:** 1.0  
**Last Updated:** February 17, 2026  
**Product Name:** [To Be Determined - Suggested: MedExpress, DawaiDash, or RxSwift]

---

## Executive Summary

### Vision Statement
To become India's most trusted and convenient prescription delivery platform that eliminates the friction of accessing medications, particularly for those who are unwell, elderly, or time-constrained.

### Problem Statement
Indian consumers face multiple pain points when filling prescriptions:
- Long queues at pharmacies, especially during illness
- Limited pharmacy hours (many close by 10 PM)
- Difficulty finding medicines due to stock issues across pharmacies
- Lack of price transparency across different chemists
- Medication adherence issues due to forgetting refills
- Mobility challenges for elderly and chronically ill patients
- Traffic and distance issues in metro cities

### Proposed Solution
A mobile-first prescription delivery platform that connects users with a network of verified pharmacies, enabling on-demand and scheduled medicine delivery with transparent pricing, automated refills, and comprehensive medication management.

---

## Market Analysis

### Target Market
**Primary Market:** Tier 1 cities (Mumbai, Delhi NCR, Bangalore, Hyderabad, Chennai, Kolkata, Pune)  
**Secondary Market:** Tier 2 cities (Ahmedabad, Jaipur, Lucknow, Chandigarh, Kochi, Indore)

### Target User Segments

1. **Urban Professionals (25-45 years)**
   - High disposable income
   - Time-constrained
   - Tech-savvy
   - Value convenience

2. **Families with Elderly Members (30-60 years)**
   - Managing chronic conditions
   - Require regular refills
   - Limited mobility of dependents

3. **Chronically Ill Patients (All ages)**
   - Diabetes, hypertension, thyroid conditions
   - Regular medication needs
   - High medication adherence importance

4. **Parents with Young Children (25-40 years)**
   - Emergency medicine needs
   - Prefer avoiding pharmacy visits when child is sick

### Market Size (India)
- Indian pharmaceutical market: ₹1.5+ lakh crore (2025)
- Online pharmacy market: ₹25,000+ crore (growing at 35% CAGR)
- Prescription medicine segment: ~70% of total pharma market

### Competitive Landscape

**Direct Competitors:**
- PharmEasy
- 1mg (Tata 1mg)
- Netmeds (Reliance)
- Apollo Pharmacy
- MedLife

**Differentiators:**
- Hyperlocal delivery model (partner with local pharmacies)
- 60-minute delivery option
- Price comparison across partner pharmacies
- User chooses preferred pharmacy
- Zero delivery charges
- Strong medication adherence features

---

## Product Goals & Success Metrics

### Business Goals (Year 1)
1. Launch in 3 metro cities
2. Onboard 500+ pharmacy partners
3. Achieve 100,000+ active users
4. Process 50,000+ orders per month
5. Maintain 4.5+ app rating
6. Achieve 30% repeat order rate

### Key Performance Indicators (KPIs)

**Acquisition Metrics:**
- Monthly Active Users (MAU)
- Cost Per Acquisition (CPA)
- App downloads
- New user registration rate

**Engagement Metrics:**
- Order frequency per user
- Refill automation adoption rate
- Average order value (AOV)
- Time spent in app

**Operational Metrics:**
- Average delivery time
- Order fulfillment rate
- Prescription verification success rate
- Pharmacy partner response time
- Medicine availability rate

**Retention Metrics:**
- 30-day retention rate
- Repeat order rate
- Churn rate
- Customer Lifetime Value (LTV)

**Customer Satisfaction:**
- Net Promoter Score (NPS)
- Customer Support response time
- App rating
- Order accuracy rate

---

## Regulatory & Compliance Requirements

### Indian Pharmaceutical Regulations

1. **Drugs and Cosmetics Act, 1940**
   - Compliance with online pharmacy guidelines
   - Proper licensing for pharmacy partners
   - Restrictions on Schedule H, H1, and X drugs

2. **Pharmacy License Requirements**
   - Valid pharmacy license for all partners
   - Registered pharmacist verification
   - Proper storage and handling compliance

3. **Prescription Validation**
   - Valid prescription required for Schedule H/H1 drugs
   - Digital prescription acceptance (post verification)
   - Prescription retention for audit (3 years minimum)

4. **Data Protection**
   - Compliance with Digital Personal Data Protection Act, 2023
   - Health data sensitivity and encryption
   - User consent management

5. **Narcotics and Psychotropic Substances**
   - Strict handling of controlled substances
   - Special documentation requirements
   - Delivery verification protocols

### Required Licenses & Certifications
- E-pharmacy license (state-specific)
- FSSAI license (for nutraceuticals/health supplements)
- GST registration
- ISO certification (recommended)

---

## User Personas

### Persona 1: Rajesh Kumar (Urban Professional)
**Age:** 32  
**Location:** Bangalore  
**Occupation:** Software Engineer  
**Income:** ₹15 LPA

**Pain Points:**
- Works 10-12 hours daily
- Gets sick occasionally, hates pharmacy queues
- Forgets to refill father's diabetes medication
- Uncertain about medicine availability

**Goals:**
- Quick medicine delivery during illness
- Automated refills for father's medicines
- Transparent pricing

**Tech Savviness:** High

---

### Persona 2: Meera Sharma (Mother & Caregiver)
**Age:** 38  
**Location:** Mumbai  
**Occupation:** Homemaker  
**Household Income:** ₹8 LPA

**Pain Points:**
- Managing medications for mother-in-law (chronic conditions)
- Emergency medicines for 6-year-old son
- Price variations across pharmacies
- Difficulty carrying heavy medicine bags

**Goals:**
- Reliable medicine delivery
- Price comparison
- Medication reminders
- Easy reordering

**Tech Savviness:** Medium

---

### Persona 3: Dr. Arvind Patel (Retired Professional)
**Age:** 67  
**Location:** Pune  
**Occupation:** Retired Bank Manager  

**Pain Points:**
- Managing multiple chronic conditions (diabetes, hypertension, thyroid)
- Physical difficulty going to pharmacy
- Forgets to refill medications
- Confusion about medicine schedules

**Goals:**
- Doorstep delivery
- Automated reminders
- Simple app interface
- Talking to pharmacist for queries

**Tech Savviness:** Low to Medium

---

## Product Features & Requirements

### Phase 1: MVP (Months 1-4)

#### 1. User Registration & Onboarding

**Features:**
- Mobile number-based registration (OTP verification)
- Email registration (optional)
- Social login (Google, Facebook - optional)
- Basic profile creation (name, age, gender, address)
- Multiple delivery address management
- Health profile (chronic conditions, allergies - optional)

**Requirements:**
- Support for 10+ Indian languages
- Aadhaar verification for controlled substances (future)
- Family member profiles (add dependents)

---

#### 2. Prescription Upload & Management

**Features:**
- Multiple upload methods:
  - Camera capture
  - Gallery selection
  - PDF upload
  - WhatsApp integration
- Prescription history storage
- OCR for prescription reading (AI-powered)
- Prescription expiry tracking
- Doctor prescription sharing integration

**Requirements:**
- Support image formats: JPG, PNG, PDF
- Maximum file size: 10 MB
- OCR accuracy: 85%+ for common medicines
- Secure encrypted storage
- Easy access to past prescriptions

---

#### 3. Medicine Search & Discovery

**Features:**
- Medicine search by:
  - Generic name
  - Brand name
  - Therapeutic category
  - Composition
- Autocomplete suggestions
- Voice search (regional languages)
- Barcode scanner
- Alternative medicine suggestions (generic substitutes)
- Medicine information:
  - Composition
  - Manufacturer
  - Uses
  - Side effects
  - Dosage instructions

**Requirements:**
- Database of 100,000+ medicines
- Real-time inventory from partner pharmacies
- Price comparison across pharmacies
- Filter by: price, distance, rating, availability

---

#### 4. Pharmacy Network & Selection

**Features:**
- View nearby pharmacies on map
- Pharmacy details:
  - Name, address, distance
  - Operating hours
  - Ratings & reviews
  - Average delivery time
  - Medicine availability
  - Price comparison
- Select preferred pharmacy
- Favorite pharmacies
- Filter pharmacies by:
  - Delivery time (express, standard)
  - Rating
  - Distance
  - Price

**Requirements:**
- Integration with Google Maps
- Real-time pharmacy availability status
- Pharmacy verification badge
- 24/7 pharmacy highlighting

---

#### 5. Order Placement & Cart

**Features:**
- Add medicines to cart
- Prescription upload during checkout
- Order summary:
  - Medicine list
  - Quantity
  - Price breakup
  - Delivery charges (₹0)
  - GST details
  - Total amount
- Select delivery address
- Choose delivery time slot
- Add special instructions
- Apply coupons/offers

**Requirements:**
- Minimum order value: ₹50
- Maximum order value: ₹50,000 (prescription limit)
- Cart persistence
- Stock availability check
- Prescription requirement validation

---

#### 6. Payment Integration

**Payment Methods:**
- UPI (PhonePe, Google Pay, Paytm, BHIM)
- Debit/Credit cards
- Net banking
- Wallets (Paytm, PhonePe, Amazon Pay)
- Cash on Delivery (COD)
- Pay Later options (Simpl, LazyPay)

**Requirements:**
- PCI DSS compliance
- Integration with Razorpay/PayU/Cashfree
- Failed payment retry
- Refund processing (5-7 business days)
- Invoice generation (GST compliant)
- Payment confirmation notifications

---

#### 7. Order Tracking & Delivery

**Features:**
- Real-time order status:
  - Prescription verification
  - Order confirmed
  - Being packed
  - Out for delivery
  - Delivered
- Live delivery tracking (GPS)
- Estimated delivery time
- Delivery executive details (name, phone)
- Call/chat with delivery executive
- Proof of delivery (photo + signature)
- Delivery instructions

**Requirements:**
- SMS notifications at each stage
- Push notifications
- WhatsApp updates (optional)
- Delivery within promised time
- Contactless delivery option
- OTP verification for controlled medicines

---

#### 8. Automated Refills

**Features:**
- Set up recurring orders
- Frequency selection (weekly, bi-weekly, monthly)
- Refill reminders (3 days before)
- One-tap reorder
- Pause/resume refills
- Edit refill orders
- Auto-renewal for chronic medications

**Requirements:**
- Valid prescription check
- Inventory availability verification
- Advance notification (72 hours)
- Easy cancellation
- Prescription renewal reminders

---

#### 9. Medicine Reminders

**Features:**
- Set medication schedules
- Dosage reminders
- Multiple medications tracking
- Snooze option
- Mark as taken
- Missed dose alerts
- Family member reminders
- Refill low-stock alerts

**Requirements:**
- Customizable reminder times
- Notification persistence
- Sync across devices
- Medicine schedule calendar view

---

#### 10. Customer Support

**Features:**
- In-app chat support
- Call support (toll-free number)
- WhatsApp support
- Email support
- FAQ section
- Help center
- Order-related queries
- Prescription assistance
- Pharmacist consultation (paid feature - future)

**Requirements:**
- 24/7 support availability
- Average response time: <5 minutes (chat)
- Multi-language support
- Ticket tracking system
- Support rating system

---

### Phase 2: Enhancement Features (Months 5-8)

#### 1. AI-Powered Features
- Smart medicine recommendations based on prescriptions
- Drug interaction warnings
- Duplicate medicine alerts
- Health condition tracking
- Personalized health tips

#### 2. Subscription Plans
- MedPlus Membership:
  - Free delivery (always)
  - Priority support
  - Extra discounts (5-10%)
  - Free health checkup vouchers
  - ₹99/month or ₹999/year

#### 3. Health Ecosystem Integration
- Integration with doctor consultation apps (Practo, 1mg Consult)
- E-prescription from doctors directly
- Diagnostic test booking
- Health records storage
- Insurance claim assistance

#### 4. Pharmacy Partner Dashboard
- Order management
- Inventory management
- Analytics & insights
- Payout tracking
- Performance metrics

#### 5. Healthcare Products
- OTC medicines
- Health supplements
- Medical devices (BP monitors, glucometers)
- Baby care products
- Personal care items

---

### Phase 3: Advanced Features (Months 9-12)

#### 1. Telemedicine Integration
- Doctor consultation booking
- Prescription generation post-consult
- Follow-up consultations
- Specialist access

#### 2. Insurance Integration
- Health insurance claim filing
- Mediclaim assistance
- Cashless transactions
- Insurance partner network

#### 3. Corporate Wellness
- Employee health benefits
- Bulk orders for organizations
- Corporate dashboards
- Health screening camps

#### 4. Loyalty Program
- Points on every order
- Referral rewards
- Tier-based benefits
- Cashback offers

---

## Technical Architecture

### Technology Stack

**Mobile Applications:**
- **iOS:** Swift, SwiftUI
- **Android:** Kotlin, Jetpack Compose
- **Cross-platform consideration:** Flutter/React Native (for faster development)

**Backend:**
- **Framework:** Node.js (Express) or Python (Django/FastAPI)
- **Database:** PostgreSQL (primary), MongoDB (for logs/analytics)
- **Cache:** Redis
- **Message Queue:** RabbitMQ/AWS SQS
- **Search:** Elasticsearch

**Cloud Infrastructure:**
- **Provider:** AWS/Google Cloud Platform
- **Services:**
  - EC2/Compute Engine (application servers)
  - S3/Cloud Storage (prescription images)
  - RDS (managed database)
  - CloudFront/Cloud CDN (content delivery)
  - Lambda/Cloud Functions (serverless functions)

**Third-Party Integrations:**
- **Maps:** Google Maps API
- **Payment Gateway:** Razorpay/PayU/Cashfree
- **SMS:** Twilio/MSG91
- **Push Notifications:** Firebase Cloud Messaging
- **Analytics:** Google Analytics, Mixpanel, Clevertap
- **OCR:** Google Vision API/AWS Textract
- **Voice:** Google Speech-to-Text

**DevOps:**
- **CI/CD:** GitHub Actions/Jenkins
- **Containerization:** Docker
- **Orchestration:** Kubernetes
- **Monitoring:** New Relic/Datadog
- **Logging:** ELK Stack

---

### System Architecture

**High-Level Components:**

1. **User-Facing Applications**
   - iOS App
   - Android App
   - Web Portal (for desktop users)

2. **Partner Applications**
   - Pharmacy Partner App
   - Delivery Partner App

3. **Admin Panel**
   - Operations dashboard
   - Pharmacy management
   - User management
   - Analytics & reporting

4. **Core Services**
   - User Service
   - Order Service
   - Prescription Service
   - Inventory Service
   - Payment Service
   - Notification Service
   - Delivery Service
   - Analytics Service

---

### Data Models

**Key Entities:**

1. **User**
   - user_id, name, email, phone, dob, gender
   - addresses[], health_profile
   - created_at, updated_at

2. **Prescription**
   - prescription_id, user_id, image_url
   - medicines[], doctor_name, date
   - expiry_date, verification_status

3. **Medicine**
   - medicine_id, name, generic_name, composition
   - manufacturer, category, requires_prescription
   - description, side_effects, dosage

4. **Pharmacy**
   - pharmacy_id, name, license_number
   - address, location, operating_hours
   - rating, verification_status

5. **Order**
   - order_id, user_id, pharmacy_id
   - medicines[], total_amount, prescription_id
   - delivery_address, status, created_at

6. **Delivery**
   - delivery_id, order_id, delivery_partner_id
   - status, estimated_time, actual_time
   - live_location, proof_of_delivery

---

### Security & Privacy

**Data Security:**
- End-to-end encryption for prescriptions
- HTTPS/TLS for all communications
- Encrypted database storage (at rest)
- Regular security audits
- PCI DSS compliance for payments
- OAuth 2.0 for authentication

**Privacy Measures:**
- GDPR-like consent management
- Data anonymization for analytics
- Right to delete data
- Prescription data retention (3 years as per law)
- Third-party data sharing disclosure

**Access Controls:**
- Role-based access control (RBAC)
- Multi-factor authentication for admin
- API rate limiting
- DDoS protection

---

## User Experience Design

### Design Principles
1. **Simplicity:** Minimize steps to order medicines
2. **Clarity:** Clear medicine information and pricing
3. **Trust:** Transparent processes, verified pharmacies
4. **Accessibility:** Support for elderly and differently-abled users
5. **Regional:** Multilingual, culturally appropriate

### Key User Flows

**Flow 1: First-time Order**
1. Download app → Register
2. Upload prescription
3. Review detected medicines → Add to cart
4. Select pharmacy (view comparison)
5. Add delivery address
6. Choose payment method → Place order
7. Track delivery → Receive medicines

**Flow 2: Reorder**
1. Open app
2. Go to "Past Orders"
3. Select order → "Reorder"
4. Confirm cart → Place order

**Flow 3: Automated Refill Setup**
1. Open app
2. Go to "My Medicines"
3. Select medicine → "Set up refill"
4. Choose frequency → Enable automation
5. Get reminder 3 days before → Approve order

---

### UI/UX Guidelines

**Color Scheme:**
- Primary: Medical blue/green (trust, health)
- Secondary: Warm orange (care, urgency)
- Background: Clean white with subtle grays
- Alerts: Red for urgent, green for success

**Typography:**
- Headers: Clear, bold sans-serif
- Body: Readable sans-serif (minimum 14px)
- Important info: Highlighted, larger font

**Icons & Images:**
- Medicine images for visual identification
- Clear icons for actions
- Pharmacy logos for brand recognition

**Accessibility:**
- High contrast mode
- Large text option
- Voice assistance
- Screen reader compatibility
- Simple language (no medical jargon)

---

## Go-to-Market Strategy

### Launch Strategy

**Phase 1: Pilot Launch (Month 1-2)**
- Location: One neighborhood in Bangalore
- Target: 500 users, 20 pharmacies
- Focus: Test operations, gather feedback
- Marketing: Word of mouth, local campaigns

**Phase 2: City Launch (Month 3-4)**
- Location: Bangalore city-wide
- Target: 10,000 users, 100 pharmacies
- Focus: Scale operations, refine product
- Marketing: Digital ads, partnerships

**Phase 3: Multi-city Launch (Month 5-8)**
- Locations: Mumbai, Delhi NCR, Hyderabad
- Target: 100,000 users, 500 pharmacies
- Focus: Market penetration
- Marketing: National campaigns

---

### Marketing Channels

**Digital Marketing:**
- Google Ads (Search & Display)
- Facebook & Instagram Ads
- YouTube pre-roll ads
- Influencer partnerships (health influencers)

**Partnerships:**
- Doctor clinics (prescription sharing)
- Diagnostic centers
- Corporate tie-ups
- Insurance companies
- Senior citizen communities

**Offline:**
- Pharmacy partnerships (co-branding)
- Residential society campaigns
- Health camps
- Print ads in newspapers

**Referral Program:**
- ₹100 credit for referrer
- ₹100 credit for new user
- Unlimited referrals

---

### Pricing Strategy

**For Users:**
- Zero delivery charges (always)
- MRP-based pricing (pharmacy sets price)
- Transparent price comparison
- Subscription benefits (future)

**For Pharmacies:**
- Commission: 8-12% per order
- Zero onboarding fee
- Performance-based incentives
- Monthly payout cycle

**For Delivery Partners:**
- Per delivery fee: ₹30-50
- Distance-based surge pricing
- Incentives for peak hours
- Weekly payouts

---

## Operational Requirements

### Pharmacy Onboarding Process
1. Registration & document verification
2. License validation
3. Pharmacist verification
4. Inventory integration
5. Training on app usage
6. Quality audit
7. Go-live

**Required Documents:**
- Pharmacy license
- Drug license
- GST certificate
- Pharmacist registration
- Bank details
- Address proof

---

### Delivery Partner Management

**Onboarding:**
- Background verification
- Vehicle documents check
- Training on app & protocols
- Medicine handling guidelines
- Uniform & ID card

**Management:**
- Zone-based assignment
- Real-time tracking
- Performance monitoring
- Safety protocols
- Insurance coverage

---

### Quality Control

**Prescription Verification:**
- Licensed pharmacist review
- AI-assisted validation
- Duplicate/fraud detection
- Controlled substance protocols

**Order Accuracy:**
- Barcode scanning
- Double-check before packing
- Tamper-proof packaging
- Delivery verification

**Customer Feedback:**
- Post-delivery rating
- Quality issue reporting
- Refund/replacement process
- Continuous improvement

---

## Risk Analysis & Mitigation

### Key Risks

**1. Regulatory Risk**
- Risk: Changes in e-pharmacy regulations
- Mitigation: Legal team monitoring, compliance buffer, government relationships

**2. Medicine Availability**
- Risk: Stock-outs impacting user experience
- Mitigation: Multiple pharmacy partnerships, real-time inventory, advance notifications

**3. Prescription Fraud**
- Risk: Fake prescriptions, controlled substance abuse
- Mitigation: AI detection, pharmacist verification, user verification for Schedule H1/X

**4. Competition**
- Risk: Established players with deep pockets
- Mitigation: Differentiated model (hyperlocal), superior UX, niche focus

**5. Delivery Issues**
- Risk: Delays, wrong deliveries, damaged medicines
- Mitigation: Partner training, quality checks, real-time tracking, insurance

**6. Data Breach**
- Risk: Health data leakage
- Mitigation: Strong encryption, regular audits, compliance certification

**7. Customer Acquisition Cost**
- Risk: High CAC impacting unit economics
- Mitigation: Referral programs, organic growth, strategic partnerships

---

## Financial Projections (Year 1)

### Revenue Model

**Primary Revenue:**
- Commission from pharmacy partners: 8-12% per order
- Average order value (AOV): ₹800
- Commission per order: ₹64-96 (avg ₹80)

**Target Orders (Month 12):**
- 50,000 orders/month
- Revenue: ₹40,00,000/month

**Additional Revenue Streams (Future):**
- Subscription fees
- Sponsored listings
- Healthcare products margin
- Telemedicine consultation fees
- Corporate wellness packages

### Cost Structure

**Technology:**
- Development: ₹50,00,000 (one-time)
- Cloud infrastructure: ₹5,00,000/month
- Third-party APIs: ₹2,00,000/month

**Operations:**
- Salaries (team of 30): ₹40,00,000/month
- Customer support: ₹5,00,000/month
- Delivery costs: ₹20/order (subsidized)

**Marketing:**
- Customer acquisition: ₹200/user
- Monthly marketing budget: ₹20,00,000

**Other:**
- Office & admin: ₹3,00,000/month
- Legal & compliance: ₹2,00,000/month

### Break-even Analysis
- Break-even target: 60,000-70,000 orders/month
- Expected timeline: Month 18-24

---

## Team & Organization

### Core Team (Phase 1)

**Leadership:**
- CEO/Co-founder (Product & Strategy)
- CTO/Co-founder (Technology)
- COO (Operations & Partnerships)

**Product & Technology (12 members):**
- Product Manager
- UX/UI Designer
- Frontend Developers (3)
- Backend Developers (3)
- Mobile Developers (2)
- QA Engineers (2)

**Operations (8 members):**
- Operations Manager
- Pharmacy Partnership Manager
- Delivery Operations Manager
- Quality Control Manager
- Supply Chain Manager
- Customer Support Team (3)

**Marketing (4 members):**
- Marketing Manager
- Digital Marketing Specialist
- Content Creator
- Partnership Manager

**Finance & Legal (3 members):**
- Finance Manager
- Legal & Compliance Officer
- Accountant

**Total Team Size:** 30 members

---

## Development Roadmap

### Month 1-2: Foundation
- Finalize product specifications
- Design system & wireframes
- Technology stack selection
- Team hiring
- Legal entity setup
- Regulatory licenses

### Month 3-4: Development
- Backend API development
- Database setup
- Mobile app development (iOS & Android)
- Admin panel development
- Third-party integrations
- Pharmacy partner app development

### Month 5-6: Testing & Pilot
- Internal testing (alpha)
- Bug fixes & optimization
- Pilot launch (one locality)
- Onboard 20 pharmacy partners
- User feedback collection
- Iterate based on feedback

### Month 7-8: Beta Launch
- City-wide beta launch (Bangalore)
- Onboard 100+ pharmacy partners
- Marketing campaigns
- Scale delivery operations
- Monitor metrics & optimize

### Month 9-12: Scale
- Launch in 2-3 additional cities
- Feature enhancements
- Automated refills rollout
- Subscription plans
- Corporate partnerships
- Achieve 100K users

---

## Success Criteria

### MVP Success Criteria (Month 6)
- 5,000+ registered users
- 1,000+ orders placed
- 50+ active pharmacy partners
- 4.0+ app rating
- <30 min average delivery time
- 95%+ prescription verification accuracy
- 20%+ repeat order rate

### Year 1 Success Criteria (Month 12)
- 100,000+ active users
- 50,000+ monthly orders
- 500+ pharmacy partners across 3-4 cities
- 4.5+ app rating
- 60%+ of orders delivered within 60 minutes
- 30%+ repeat order rate
- Positive unit economics

---

## Appendices

### Appendix A: Indian Pharmaceutical Market Insights
- 60% of medicine purchases are prescription-based
- Average household medicine expenditure: ₹5,000-10,000/year
- 30% of Indians have at least one chronic condition
- Diabetes patients in India: 101+ million (2025)
- Medicine adherence rate: ~50% (significant opportunity)

### Appendix B: Sample User Scenarios

**Scenario 1: Emergency Medicine**
Rahul's 4-year-old daughter has high fever at 11 PM. Local pharmacy is closed. He opens the app, uploads the doctor's prescription for fever medicine, finds a 24-hour pharmacy 2km away, and gets the medicine delivered in 45 minutes.

**Scenario 2: Chronic Medication Management**
Mrs. Gupta (65) has diabetes and hypertension. She sets up automated monthly refills for her 5 medicines through the app. Every month, 3 days before her medicines run out, she gets a reminder and approves the order with one tap. Medicines are delivered the next day.

**Scenario 3: Price Comparison**
Amit needs to purchase expensive cardiac medication. He uploads the prescription and sees prices from 5 different pharmacies ranging from ₹1,200 to ₹1,500. He chooses the most affordable option and saves ₹300.

### Appendix C: Competitive Analysis Matrix

| Feature | Our Product | PharmEasy | 1mg | Netmeds |
|---------|-------------|-----------|-----|---------|
| Hyperlocal Pharmacy Network | ✓ | ✗ | ✗ | ✗ |
| User Chooses Pharmacy | ✓ | ✗ | ✗ | ✗ |
| Price Comparison | ✓ | ✗ | Limited | ✗ |
| 60-min Delivery | ✓ | ✗ | Limited | ✗ |
| Zero Delivery Charge | ✓ | Conditional | Conditional | Conditional |
| Automated Refills | ✓ | ✓ | ✓ | ✓ |
| Medication Reminders | ✓ | ✓ | ✓ | ✓ |
| 24/7 Availability | ✓ | Limited | Limited | Limited |

---

## Conclusion

This PRD outlines a comprehensive prescription delivery platform designed specifically for the Indian market. The product addresses critical pain points of accessibility, convenience, and price transparency while complying with Indian pharmaceutical regulations.

**Key Differentiators:**
1. Hyperlocal pharmacy network model
2. User choice and price transparency
3. Ultra-fast delivery (60 minutes)
4. Zero delivery charges
5. Strong medication adherence features

**Next Steps:**
1. Validate assumptions through user research
2. Finalize technology stack and architecture
3. Secure initial funding
4. Build core team
5. Begin MVP development
6. Obtain necessary regulatory approvals

The success of this platform will depend on excellent execution across product, operations, and customer experience while building trust in a highly sensitive healthcare domain.

---

**Document Owner:** Product Team  
**Stakeholders:** CEO, CTO, COO, Investors  
**Review Cycle:** Bi-weekly  
**Feedback:** [Contact details]
