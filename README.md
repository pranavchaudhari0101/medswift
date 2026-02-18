# 💊 MedSwift — Prescription Delivery Platform

> Fast, reliable prescription medicine delivery for India.

MedSwift connects patients with nearby pharmacies for medicine search, price comparison, prescription uploads, and doorstep delivery — all from a single mobile app.

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🔐 **Authentication** | Phone-based login/register with JWT tokens |
| 🔍 **Medicine Search** | Real-time search with debounce across 12+ medicines |
| 💊 **Medicine Detail** | Dosage, side effects, alternatives, and price comparison |
| 🏥 **Pharmacy Browsing** | Nearby pharmacies with ratings, hours, and inventory |
| 🛒 **Smart Cart** | Add medicines, adjust quantities, swipe-to-delete |
| 📦 **3-Step Checkout** | Address → Payment → Review → Place Order |
| 📋 **Order Tracking** | Real-time order status with color-coded badges |
| 📄 **Prescriptions** | Upload and manage prescription images |
| 👤 **User Profile** | Edit profile, manage addresses, view history |
| 🎨 **Premium UI** | Staggered animations, gradients, glassmorphism |

---

## 🏗️ Architecture

```
┌─────────────────────┐          ┌─────────────────────┐
│   Flutter Frontend   │  REST   │  Spring Boot Backend │
│   (Riverpod + Dio)  │ ──────▶ │  (JPA + JWT + H2)   │
│   Port: dynamic     │  JSON   │  Port: 8080          │
└─────────────────────┘          └─────────────────────┘
```

📖 See [SYSTEM_ARCHITECTURE.md](SYSTEM_ARCHITECTURE.md) for the full technical deep-dive.

---

## 🛠️ Tech Stack

### Backend
- **Java 17** + **Spring Boot 3.2.0**
- Spring Security + JWT (jjwt 0.12.3)
- Spring Data JPA + H2 (dev) / PostgreSQL (prod)
- SpringDoc OpenAPI (Swagger UI)

### Frontend
- **Flutter** (Dart SDK ≥3.2.0)
- **Riverpod** — State management
- **Dio** — HTTP client with interceptors
- **GoRouter** — Declarative navigation
- **flutter_secure_storage** — Encrypted token storage

---

## 🚀 Getting Started

### Prerequisites
- Java 17+ ([Download](https://adoptium.net/))
- Maven 3.9+ ([Download](https://maven.apache.org/download.cgi))
- Flutter SDK ≥3.2.0 ([Download](https://flutter.dev/docs/get-started/install))

### 1. Clone the repository

```bash
git clone https://github.com/pranavchaudhari0101/medswift.git
cd medswift
```

### 2. Start the Backend

```bash
cd backend
mvn spring-boot:run
```

The server starts at `http://localhost:8080`. It auto-seeds:
- 12 medicines, 6 pharmacies, 72 inventory entries
- Demo user: **phone** `9999999999`, **password** `demo123`

**Swagger UI:** [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)
**H2 Console:** [http://localhost:8080/h2-console](http://localhost:8080/h2-console) (JDBC URL: `jdbc:h2:mem:medswiftdb`)

### 3. Run the Frontend

```bash
cd frontend
flutter pub get
flutter run -d windows    # or: flutter run -d chrome / -d android
```

### 4. Login with Demo Credentials

```
Phone:    9999999999
Password: demo123
```

---

## 📂 Project Structure

```
medswift/
├── backend/                           # Spring Boot API
│   ├── src/main/java/com/medswift/
│   │   ├── controller/                # 6 REST controllers
│   │   ├── service/                   # 5 business services
│   │   ├── model/                     # 9 JPA entities
│   │   ├── repository/               # 8 data repositories
│   │   ├── security/                  # JWT auth + filters
│   │   ├── dto/                       # Request/Response DTOs
│   │   ├── config/                    # DataSeeder
│   │   └── exception/                # Error handlers
│   └── src/main/resources/
│       └── application.yml            # Server config
│
├── frontend/                          # Flutter App
│   └── lib/
│       ├── core/                      # Shared: models, services, providers, theme
│       └── features/                  # Screen modules
│           ├── auth/                  # Login, Register
│           ├── home/                  # Home, MainShell (tab bar)
│           ├── medicine/              # Search, Detail
│           ├── pharmacy/              # Pharmacy List
│           ├── cart/                   # Cart, Checkout, Order Success
│           ├── order/                 # History, Tracking
│           ├── prescription/          # Upload
│           └── profile/               # Profile, Edit, Addresses, etc.
│
├── SYSTEM_ARCHITECTURE.md             # Full system design document
└── README.md                          # This file
```

---

## 📡 API Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|:----:|-------------|
| POST | `/api/auth/register` | ❌ | Register user |
| POST | `/api/auth/login` | ❌ | Login → JWT |
| GET | `/api/medicines/search?query=` | ❌ | Search medicines |
| GET | `/api/medicines/{id}` | ❌ | Medicine detail |
| GET | `/api/medicines/{id}/prices` | ❌ | Price comparison |
| GET | `/api/medicines/{id}/alternatives` | ❌ | Alternatives |
| GET | `/api/pharmacies` | ❌ | Nearby pharmacies |
| GET | `/api/pharmacies/{id}` | ❌ | Pharmacy detail |
| POST | `/api/orders` | ✅ | Place order |
| GET | `/api/orders` | ✅ | Order history |
| GET | `/api/orders/{id}` | ✅ | Order detail |
| PUT | `/api/orders/{id}/cancel` | ✅ | Cancel order |
| GET | `/api/users/profile` | ✅ | User profile |
| PUT | `/api/users/profile` | ✅ | Update profile |
| GET | `/api/users/addresses` | ✅ | List addresses |
| POST | `/api/users/addresses` | ✅ | Add address |
| POST | `/api/prescriptions/upload` | ✅ | Upload prescription |

---

## 📱 App Screenshots

| Onboarding | Home | Medicine Detail |
|:---:|:---:|:---:|
| Swipeable intro slides | Popular medicines + nearby pharmacies | Dosage, prices, add to cart |

| Cart | Checkout | Order Success |
|:---:|:---:|:---:|
| Quantity controls, swipe-delete | 3-step: Address → Payment → Review | Animated confirmation |

---

## 🔒 Security

- **JWT Authentication** with 24-hour token expiry
- **BCrypt** password hashing
- **flutter_secure_storage** for encrypted token persistence
- **CORS** configured for development
- Public endpoints: medicines, pharmacies, auth
- Protected endpoints: orders, profile, prescriptions

---

## 🗺️ Roadmap

- [ ] Real payment gateway integration (Razorpay)
- [ ] Push notifications (Firebase)
- [ ] Real-time delivery tracking (WebSocket)
- [ ] Medicine reminders with local notifications
- [ ] Multi-language support (Hindi, Marathi, etc.)
- [ ] PostgreSQL migration for production
- [ ] Docker + CI/CD pipeline
- [ ] Android & iOS release builds

---

## 📝 License

This project is for educational and demonstration purposes.

---

*Built with ❤️ for India's healthcare delivery*
