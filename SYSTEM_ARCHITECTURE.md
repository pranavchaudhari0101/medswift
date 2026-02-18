# 🏗️ MedSwift — System Architecture

> Complete technical architecture of the MedSwift Prescription Delivery Platform.

---

## 1. System Overview

MedSwift is a **full-stack prescription medicine delivery platform** built for the Indian market. It connects patients with nearby pharmacies, enabling medicine search, price comparison, prescription uploads, and doorstep delivery.

```
┌─────────────────────────────────────────────────────────────────┐
│                        CLIENT LAYER                             │
│                                                                 │
│   ┌─────────────┐  ┌──────────────┐  ┌───────────────────────┐  │
│   │  Flutter     │  │  Riverpod    │  │  GoRouter             │  │
│   │  UI Widgets  │──│  Providers   │──│  Navigation           │  │
│   └─────────────┘  └──────┬───────┘  └───────────────────────┘  │
│                           │                                     │
│                    ┌──────┴───────┐                              │
│                    │  Dio Client  │                              │
│                    │  (HTTP + JWT)│                              │
│                    └──────┬───────┘                              │
└───────────────────────────┼─────────────────────────────────────┘
                            │  REST / JSON
                            │  Port 8080
┌───────────────────────────┼─────────────────────────────────────┐
│                    SERVER LAYER                                  │
│                           │                                     │
│   ┌───────────────────────┴───────────────────────────────────┐ │
│   │              Spring Security Filter Chain                 │ │
│   │  ┌────────────┐  ┌──────────────┐  ┌──────────────────┐  │ │
│   │  │ CORS Filter│──│ JWT Auth     │──│ SecurityConfig    │  │ │
│   │  │            │  │ Filter       │  │ (permitAll/auth)  │  │ │
│   │  └────────────┘  └──────────────┘  └──────────────────┘  │ │
│   └───────────────────────┬───────────────────────────────────┘ │
│                           │                                     │
│   ┌───────────────────────┴───────────────────────────────────┐ │
│   │                  REST Controllers                         │ │
│   │  Auth │ Medicine │ Pharmacy │ Order │ User │ Prescription │ │
│   └───────────────────────┬───────────────────────────────────┘ │
│                           │                                     │
│   ┌───────────────────────┴───────────────────────────────────┐ │
│   │                  Service Layer                            │ │
│   │  AuthService │ MedicineService │ OrderService │ ...       │ │
│   └───────────────────────┬───────────────────────────────────┘ │
│                           │                                     │
│   ┌───────────────────────┴───────────────────────────────────┐ │
│   │              JPA Repositories + Entities                  │ │
│   │  User │ Medicine │ Pharmacy │ Order │ OrderItem │ ...     │ │
│   └───────────────────────┬───────────────────────────────────┘ │
│                           │                                     │
│                    ┌──────┴───────┐                              │
│                    │  H2 / PGSQL  │                              │
│                    │  Database    │                              │
│                    └──────────────┘                              │
└─────────────────────────────────────────────────────────────────┘
```

---

## 2. Technology Stack

### Backend
| Component | Technology | Version |
|-----------|-----------|---------|
| Framework | Spring Boot | 3.2.0 |
| Language | Java | 17 |
| Build | Maven | 3.9+ |
| ORM | Spring Data JPA / Hibernate | - |
| Security | Spring Security + JWT | jjwt 0.12.3 |
| Database (Dev) | H2 In-Memory | - |
| Database (Prod) | PostgreSQL | - |
| API Docs | SpringDoc OpenAPI (Swagger) | 2.3.0 |
| Validation | Jakarta Bean Validation | - |

### Frontend
| Component | Technology | Version |
|-----------|-----------|---------|
| Framework | Flutter | SDK ≥3.2.0 |
| Language | Dart | - |
| State Management | Riverpod | 2.4.9 |
| Networking | Dio | 5.4.0 |
| Navigation | GoRouter | 13.0.1 |
| Secure Storage | flutter_secure_storage | 9.0.0 |
| Typography | Google Fonts | 6.1.0 |
| Animations | flutter_animate, Lottie | - |
| Icons | Iconsax, Cupertino Icons | - |

---

## 3. Backend Architecture (Spring Boot)

### 3.1 Package Structure

```
com.medswift/
├── MedSwiftApplication.java          # Entry point
├── config/
│   └── DataSeeder.java               # Seeds demo data on startup
├── controller/                        # REST API endpoints
│   ├── AuthController.java           # POST /api/auth/login, /register
│   ├── MedicineController.java       # GET /api/medicines/**
│   ├── PharmacyController.java       # GET /api/pharmacies/**
│   ├── OrderController.java          # CRUD /api/orders/**
│   ├── UserController.java           # GET/PUT /api/users/**
│   └── PrescriptionController.java   # POST /api/prescriptions/**
├── dto/                               # Data Transfer Objects
│   ├── AuthDto.java                  # LoginRequest, RegisterRequest, AuthResponse
│   ├── MedicineDto.java              # MedicineResponse, PriceComparison
│   ├── PharmacyDto.java              # PharmacyResponse
│   ├── OrderDto.java                 # CreateOrderRequest, OrderResponse
│   ├── UserDto.java                  # ProfileResponse, UpdateRequest
│   └── ApiResponse.java             # Generic Success<T> wrapper
├── model/                             # JPA Entities
│   ├── User.java                     # Users + roles
│   ├── Medicine.java                 # Medicine catalog
│   ├── Pharmacy.java                 # Pharmacy locations
│   ├── PharmacyInventory.java        # Medicine-Pharmacy pricing
│   ├── Order.java                    # Order header
│   ├── OrderItem.java                # Order line items
│   ├── Delivery.java                 # Delivery tracking
│   ├── Prescription.java            # Uploaded prescriptions
│   └── Address.java                  # User addresses
├── repository/                        # Spring Data JPA repositories
│   └── (8 repository interfaces)
├── service/                           # Business logic
│   ├── AuthService.java              # Registration, login, JWT
│   ├── MedicineService.java          # Search, detail, alternatives, prices
│   ├── PharmacyService.java          # Nearby, detail, inventory
│   ├── OrderService.java             # Create, track, cancel
│   └── UserService.java             # Profile, address CRUD
├── security/                          # Security layer
│   ├── SecurityConfig.java           # Filter chain, CORS, public routes
│   ├── JwtTokenProvider.java         # Token generation + validation
│   └── JwtAuthFilter.java           # OncePerRequestFilter
└── exception/                         # Error handling
    └── (3 exception classes)
```

### 3.2 Entity-Relationship Model

```
┌──────────────┐        ┌──────────────────┐        ┌──────────────┐
│     User     │ 1───M  │     Address      │        │   Medicine   │
│──────────────│        │──────────────────│        │──────────────│
│ id           │        │ id               │        │ id           │
│ name         │        │ label            │        │ name         │
│ phone        │        │ street           │        │ genericName  │
│ email        │        │ city, state, zip │        │ manufacturer │
│ passwordHash │        │ latitude         │        │ category     │
│ role         │        │ longitude        │        │ description  │
│ createdAt    │        │ isDefault        │        │ dosageForm   │
└──────┬───────┘        └──────────────────┘        │ strength     │
       │                                             │ sideEffects  │
       │ 1                                           │ isOTC        │
       │                                             │ imageUrl     │
       ├──M──────────────────┐                       └──────┬───────┘
       │                     │                              │
┌──────┴───────┐      ┌──────┴──────────┐                   │
│    Order     │      │  Prescription   │                   │
│──────────────│      │─────────────────│                   │
│ id           │      │ id              │                   │
│ userId       │      │ userId          │            ┌──────┴────────────┐
│ pharmacyId   │      │ imageUrl        │            │PharmacyInventory  │
│ status       │      │ status          │            │───────────────────│
│ totalAmount  │      │ notes           │            │ id                │
│ paymentMethod│      │ createdAt       │            │ pharmacyId        │
│ deliveryAddr │      └─────────────────┘            │ medicineId        │
│ createdAt    │                                     │ price             │
└──────┬───────┘                                     │ stock             │
       │                                             │ discount          │
       │ 1                                           └────────┬─────────┘
       │                                                      │
       ├──M──────────────┐                                    │
       │                 │                              ┌─────┴────────┐
┌──────┴───────┐  ┌──────┴───────┐                      │   Pharmacy   │
│  OrderItem   │  │   Delivery   │                      │──────────────│
│──────────────│  │──────────────│                      │ id           │
│ id           │  │ id           │                      │ name         │
│ orderId      │  │ orderId      │                      │ address      │
│ medicineId   │  │ status       │                      │ phone        │
│ quantity     │  │ latitude     │                      │ latitude     │
│ unitPrice    │  │ longitude    │                      │ longitude    │
│ totalPrice   │  │ estimatedAt  │                      │ rating       │
└──────────────┘  │ deliveredAt  │                      │ isOpen       │
                  └──────────────┘                      │ openTime     │
                                                        │ closeTime    │
                                                        └──────────────┘
```

### 3.3 API Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| **Authentication** ||||
| POST | `/api/auth/register` | ❌ | Register new user |
| POST | `/api/auth/login` | ❌ | Login, returns JWT |
| **Medicines** ||||
| GET | `/api/medicines/search?query=&page=&size=` | ❌ | Search medicines |
| GET | `/api/medicines/{id}` | ❌ | Medicine details |
| GET | `/api/medicines/{id}/alternatives` | ❌ | Generic alternatives |
| GET | `/api/medicines/{id}/prices` | ❌ | Price comparison across pharmacies |
| **Pharmacies** ||||
| GET | `/api/pharmacies?lat=&lng=&radius=` | ❌ | Nearby pharmacies |
| GET | `/api/pharmacies/{id}` | ❌ | Pharmacy details + inventory |
| **Orders** ||||
| POST | `/api/orders` | ✅ | Place new order |
| GET | `/api/orders` | ✅ | User's order history |
| GET | `/api/orders/{id}` | ✅ | Order details |
| PUT | `/api/orders/{id}/cancel` | ✅ | Cancel order |
| **Users** ||||
| GET | `/api/users/profile` | ✅ | Get user profile |
| PUT | `/api/users/profile` | ✅ | Update profile |
| GET | `/api/users/addresses` | ✅ | List addresses |
| POST | `/api/users/addresses` | ✅ | Add address |
| DELETE | `/api/users/addresses/{id}` | ✅ | Delete address |
| **Prescriptions** ||||
| POST | `/api/prescriptions/upload` | ✅ | Upload prescription |
| GET | `/api/prescriptions` | ✅ | List prescriptions |

### 3.4 Security Architecture

```
Request Flow:
─────────────────────────────────────────────────────────────
  Client Request
       │
       ▼
  ┌─────────────────┐   Public endpoints bypass JWT:
  │   CORS Filter    │   - /api/auth/**
  └────────┬────────┘   - /api/medicines/**
           │             - /api/pharmacies/**
  ┌────────▼────────┐   - /swagger-ui/**, /v3/api-docs/**
  │  JwtAuthFilter   │   - /h2-console/**
  │                  │
  │  1. Extract      │
  │     Bearer token │
  │  2. Validate JWT │
  │  3. Load user    │
  │  4. Set security │
  │     context      │
  └────────┬────────┘
           │
  ┌────────▼────────┐
  │ SecurityConfig   │   All other endpoints → authenticated
  │ Authorization    │
  └────────┬────────┘
           │
  ┌────────▼────────┐
  │   Controller     │
  └─────────────────┘
─────────────────────────────────────────────────────────────

JWT Token:
  Header:  { alg: HS256 }
  Payload: { sub: phone, iat, exp }
  Secret:  Configured in application.yml
  Expiry:  24 hours (86400000 ms)
```

### 3.5 Data Seeder

On startup, `DataSeeder.java` (implements `CommandLineRunner`) populates:

| Data | Count | Examples |
|------|-------|---------|
| Medicines | 12 | Paracetamol, Amoxicillin, Metformin, Cetirizine, Omeprazole... |
| Pharmacies | 6 | MedPlus, Apollo Pharmacy, Netmeds Express... |
| Inventory | 72 | 6 pharmacies × 12 medicines with random pricing/stock |
| Demo User | 1 | Phone: `9999999999`, Password: `demo123` |

---

## 4. Frontend Architecture (Flutter)

### 4.1 Project Structure

```
lib/
├── main.dart                          # Entry: ProviderScope + App
├── app.dart                           # MaterialApp.router + theme
│
├── core/                              # Shared infrastructure
│   ├── models/                        # Dart data classes
│   │   ├── api_response.dart          # Generic API response wrapper
│   │   ├── auth_models.dart           # Login/Register DTOs
│   │   ├── medicine_models.dart       # Medicine, PriceComparison
│   │   ├── pharmacy_models.dart       # Pharmacy
│   │   ├── order_models.dart          # Order request/response
│   │   ├── user_models.dart           # UserProfile, UserAddress
│   │   └── cart_item.dart             # Local cart item
│   │
│   ├── network/
│   │   └── dio_client.dart            # Dio setup, base URL, interceptors
│   │
│   ├── providers/                     # Riverpod state management
│   │   ├── auth_provider.dart         # AuthNotifier (login/register/logout)
│   │   ├── medicine_provider.dart     # Search, detail, prices, alternatives
│   │   ├── pharmacy_provider.dart     # List, detail
│   │   ├── order_provider.dart        # Order list, detail, service
│   │   ├── cart_provider.dart         # CartNotifier (add/remove/qty/total)
│   │   └── user_provider.dart         # Profile, addresses
│   │
│   ├── services/                      # API service classes
│   │   ├── auth_service.dart
│   │   ├── medicine_service.dart
│   │   ├── pharmacy_service.dart
│   │   ├── order_service.dart
│   │   ├── user_service.dart
│   │   └── prescription_service.dart
│   │
│   ├── router/
│   │   └── app_router.dart            # GoRouter config + routes
│   │
│   ├── theme/
│   │   ├── app_colors.dart            # Color palette + gradients
│   │   └── app_theme.dart             # ThemeData
│   │
│   └── widgets/                       # Reusable UI components
│       ├── staggered_animation.dart   # SlideUpFadeIn
│       └── animated_scale_button.dart # Tap-scale button
│
└── features/                          # Feature modules
    ├── onboarding/presentation/       # OnboardingScreen
    ├── auth/presentation/             # LoginScreen, RegisterScreen
    ├── home/presentation/             # HomeScreen, MainShell (bottom nav)
    ├── medicine/presentation/         # MedicineSearchScreen, MedicineDetailScreen
    ├── pharmacy/presentation/         # PharmacyListScreen
    ├── cart/presentation/             # CartScreen, CheckoutScreen, OrderSuccessScreen
    ├── order/presentation/            # OrderHistoryScreen, OrderTrackingScreen
    ├── prescription/presentation/     # PrescriptionUploadScreen
    └── profile/presentation/          # ProfileScreen, EditProfile, Addresses,
                                       # Notifications, Reminders, Help, About
```

### 4.2 State Management Flow

```
┌──────────────────────────────────────────────────────────────┐
│                     Riverpod Provider Tree                    │
│                                                              │
│  ┌─────────────┐     ┌──────────────┐     ┌──────────────┐  │
│  │ dioProvider  │────▶│ *Service     │────▶│ *Provider    │  │
│  │ (singleton)  │     │ (API calls)  │     │ (state)      │  │
│  └─────────────┘     └──────────────┘     └──────┬───────┘  │
│                                                   │          │
│                                            ┌──────▼───────┐  │
│                                            │  UI Widget   │  │
│                                            │ (Consumer)   │  │
│                                            └──────────────┘  │
└──────────────────────────────────────────────────────────────┘

Provider Types:
  ├── StateNotifierProvider  → authProvider, cartProvider
  ├── FutureProvider.family  → medicineDetailProvider(id)
  ├── FutureProvider         → ordersProvider, userProfileProvider
  └── Provider               → dioProvider, orderServiceProvider
```

### 4.3 Screen Flow & Navigation

```
                    ┌─────────────┐
                    │ Onboarding  │
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
              ┌─────│    Login    │─────┐
              │     └──────┬──────┘     │
              │            │            │
       ┌──────▼──────┐     │     ┌──────▼──────┐
       │  Register   │     │     │   Forgot    │
       └──────┬──────┘     │     │   Password  │
              │            │     └─────────────┘
              └─────┬──────┘
                    │
         ┌──────────▼──────────┐
         │   MainShell (Tabs)  │
         │  ┌──────────────┐   │
         │  │ 🏠 Home      │   │───▶ Medicine Detail ───▶ Add to Cart
         │  │ 🔍 Search    │   │          │                    │
         │  │ 📋 Orders    │   │          ▼                    ▼
         │  │ 👤 Profile   │   │   Price Comparison      ┌─────────┐
         │  └──────────────┘   │                         │  Cart   │
         └─────────────────────┘                         └────┬────┘
                    │                                         │
                    │                                  ┌──────▼──────┐
         ┌──────────┼──────────┐                       │  Checkout   │
         │          │          │                       │ (3 steps)   │
    ┌────▼───┐ ┌────▼───┐ ┌───▼────┐                  └──────┬──────┘
    │Pharmacy│ │Prescrip│ │Order   │                         │
    │ List   │ │ Upload │ │Tracking│                  ┌──────▼──────┐
    └────────┘ └────────┘ └────────┘                  │   Order     │
                                                      │   Success   │
    Profile Sub-routes:                               └─────────────┘
    ├── Edit Profile
    ├── Manage Addresses
    ├── Notifications
    ├── Medicine Reminders
    ├── Help & Support
    └── About MedSwift
```

### 4.4 Networking Layer

```
┌──────────────────────────────────────────────────┐
│                  DioClient                        │
│──────────────────────────────────────────────────│
│  Base URL: http://localhost:8080                  │
│                                                  │
│  Interceptors:                                   │
│  ┌────────────────────────────────────────────┐  │
│  │ 1. Auth Interceptor                        │  │
│  │    - Adds "Authorization: Bearer <token>"  │  │
│  │    - Reads token from flutter_secure_store │  │
│  ├────────────────────────────────────────────┤  │
│  │ 2. Debug Log Interceptor                   │  │
│  │    - Logs request method, URL, status      │  │
│  ├────────────────────────────────────────────┤  │
│  │ 3. Error Interceptor                       │  │
│  │    - 401 → Clear token → Redirect /login   │  │
│  └────────────────────────────────────────────┘  │
│                                                  │
│  Token Storage: flutter_secure_storage            │
│  - loadToken() on app start (auto-login)         │
│  - saveToken() on login/register success         │
│  - clearToken() on logout or 401                 │
└──────────────────────────────────────────────────┘
```

---

## 5. Data Flow: Order Placement (End-to-End)

```
 User taps "Add to Cart" on MedicineDetailScreen
       │
       ▼
 CartNotifier.addItem(medicine, pharmacyId, name, price)
       │  (stored in-memory, Riverpod state)
       ▼
 User navigates to /cart → CartScreen
       │  - View items, adjust quantities
       │  - Swipe to delete
       ▼
 User taps "Proceed to Checkout" → /checkout
       │
       ▼
 CheckoutScreen — Step 0: Address
       │  - Loads addresses from addressesProvider (GET /api/users/addresses)
       │  - User selects saved or enters new address
       ▼
 CheckoutScreen — Step 1: Payment
       │  - User selects COD / UPI / Card
       ▼
 CheckoutScreen — Step 2: Review
       │  - Order summary, special instructions
       ▼
 User taps "Place Order"
       │
       ▼
 OrderService.createOrder(CreateOrderRequest)
       │  POST /api/orders
       │  Body: { pharmacyId, items[], deliveryAddress, paymentMethod }
       │
       ▼
 Backend: OrderService.createOrder()
       │  1. Validate pharmacy & items exist
       │  2. Calculate prices from PharmacyInventory
       │  3. Create Order + OrderItems
       │  4. Set status = "PENDING"
       │  5. Return OrderResponse
       │
       ▼
 Frontend receives OrderResponse
       │  1. CartNotifier.clear()
       │  2. Navigate to /order-success/{id}
       │
       ▼
 OrderSuccessScreen
       │  - Animated checkmark
       │  - "Track Order" → /order/{id}
       │  - "Continue Shopping" → /home
```

---

## 6. Authentication Flow

```
┌──────────┐                          ┌──────────────┐
│  Client  │                          │   Backend    │
└────┬─────┘                          └──────┬───────┘
     │                                       │
     │  POST /api/auth/register              │
     │  { name, phone, password }            │
     │──────────────────────────────────────▶│
     │                                       │  Hash password (BCrypt)
     │                                       │  Save User entity
     │                                       │  Generate JWT
     │  { token, name, phone }               │
     │◀──────────────────────────────────────│
     │                                       │
     │  Save token                           │
     │  (flutter_secure_storage)             │
     │                                       │
     │  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│
     │        Subsequent API calls           │
     │  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│
     │                                       │
     │  GET /api/orders                      │
     │  Authorization: Bearer <jwt>          │
     │──────────────────────────────────────▶│
     │                                       │  JwtAuthFilter:
     │                                       │  1. Extract token
     │                                       │  2. Validate signature
     │                                       │  3. Check expiry
     │                                       │  4. Load UserDetails
     │  200 OK + data                        │  5. Set SecurityContext
     │◀──────────────────────────────────────│
     │                                       │
     │  ─ ─ ─ ─ Token expired ─ ─ ─ ─ ─ ─ ─│
     │                                       │
     │  401 Unauthorized                     │
     │◀──────────────────────────────────────│
     │                                       │
     │  DioClient error interceptor:         │
     │  1. Clear stored token                │
     │  2. Navigate to /login                │
     │                                       │
```

---

## 7. Deployment Architecture

### Development (Current)

```
┌────────────────────┐     ┌────────────────────┐
│  Flutter Debug App  │────▶│  Spring Boot       │
│  (Windows/Android)  │     │  localhost:8080     │
│                    │     │  H2 In-Memory DB   │
└────────────────────┘     └────────────────────┘
```

### Production (Target)

```
┌──────────────┐     ┌──────────────┐     ┌────────────────┐
│   Flutter    │     │   Nginx      │     │  Spring Boot   │
│   Mobile App │────▶│   Reverse    │────▶│  (Docker)      │
│  (APK/IPA)  │     │   Proxy      │     │                │
└──────────────┘     │   + SSL      │     │  Port 8080     │
                     └──────────────┘     └────────┬───────┘
                                                    │
                                          ┌─────────▼────────┐
                                          │   PostgreSQL     │
                                          │   Database       │
                                          └──────────────────┘

Production Checklist:
  □ Switch H2 → PostgreSQL in application.yml
  □ Set strong JWT secret via environment variable
  □ Enable HTTPS with valid SSL certificate
  □ Configure CORS for production domain
  □ Add rate limiting on auth endpoints
  □ Set up database backups
  □ Implement real payment gateway (Razorpay/PayTM)
  □ Add push notifications (Firebase)
  □ Build Flutter release APK/IPA
```

---

## 8. Configuration Reference

### Backend (`application.yml`)

```yaml
server:
  port: 8080

spring:
  datasource:
    url: jdbc:h2:mem:medswiftdb      # Dev: H2
    # url: jdbc:postgresql://...     # Prod: PostgreSQL
  jpa:
    hibernate:
      ddl-auto: create-drop          # Dev: recreate on restart
  h2:
    console:
      enabled: true                  # Dev: /h2-console

app:
  jwt:
    secret: <base64-encoded-key>
    expiration: 86400000             # 24 hours
```

### Frontend (`dio_client.dart`)

```dart
baseUrl: 'http://localhost:8080'     // Dev
// baseUrl: 'https://api.medswift.in'  // Prod
```

---

## 9. Key Design Decisions

| Decision | Rationale |
|----------|-----------|
| **H2 for development** | Zero setup, auto-creates schema, seeded data resets on restart |
| **Phone-based auth** | India market — users login via phone number, not email |
| **Cart in-memory** | Cart is local to device; no backend cart API needed until multi-device sync |
| **Single pharmacy per order** | Simplifies order fulfillment and delivery logistics |
| **Medicine & Pharmacy public** | No login needed to browse → better UX and conversion |
| **Riverpod over BLoC** | Less boilerplate, better testability, family providers for parameterized queries |
| **GoRouter** | Declarative routing with deep linking support, URL-based navigation |
| **JWT in secure storage** | `flutter_secure_storage` uses platform Keychain/Keystore for encrypted persistence |

---

*Document generated for MedSwift v1.0.0 — February 2026*
