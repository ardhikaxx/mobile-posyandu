# 📱 Mobile Posyandu

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.9.2-blue?style=for-the-badge&logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.0.0-blue?style=for-the-badge&logo=dart" alt="Dart">
  <img src="https://img.shields.io/badge/License-Educational-green?style=for-the-badge" alt="License">
</p>

> Aplikasi mobile Posyandu (Pos Layanan Terpadu) untuk membantu ibu dalam memantau kesehatan dan perkembangan anak dengan mudah dan praktis.

---

## ✨ Fitur Utama

### 🔐 Autentikasi
| Fitur | Deskripsi |
|-------|-----------|
| Login | Masuk ke aplikasi dengan akun yang terdaftar |
| Register | Mendaftarkan akun baru |
| Lupa Password | Mengatur ulang kata sandi yang lupa |
| Ganti Password | Mengubah kata sandi akun |

### 📊 Dashboard
- Menampilkan pesan selamat datang dengan nama ibu
- Melihat jadwal posyandu bulan ini
- Melihat data perkembangan anak (berat & tinggi badan)
- Indikator tren perkembangan (naik 📈, turun 📉, stabil ➡️)

### 💉 Imunisasi
- Melihat riwayat imunisasi anak
- Informasi jadwal imunisasi lengkap
- Detail imunisasi masing-masing anak

### 📈 Grafik Pertumbuhan
- Grafik pertumbuhan berat badan anak
- Grafik pertumbuhan tinggi badan anak
- Visualisasi data posyandu interaktif

### 📚 Edukasi
- Artikel kesehatan ibu dan anak
- Tips perawatan kesehatan
- Informasi tentang tumbuh kembang anak

### 👤 Profil Pengguna
- Melihat data profil
- Mengedit informasi profil

---

## 🛠️ Teknologi yang Digunakan

<div align="center">

| Teknologi | Penggunaan |
|------------|------------|
| <img src="https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter" height="20"> | Framework cross-platform |
| <img src="https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart" height="20"> | Bahasa pemrograman |
| <img src="https://img.shields.io/badge/GetX-4.6.6-red?style=flat" height="20"> | State management & routing |
| <img src="https://img.shields.io/badge/Dio-5.4.3-blue?style=flat" height="20"> | HTTP client |
| <img src="https://img.shields.io/badge/Syncfusion-Charts-orange?style=flat" height="20"> | Visualisasi grafik |
| <img src="https://img.shields.io/badge/SQLite-2.3.3-green?style=flat" height="20"> | Local database |
| <img src="https://img.shields.io/badge/SharedPreferences-2.2.3-blue?style=flat" height="20"> | Penyimpanan lokal |

</div>

---

## 📁 Struktur Proyek

```
📂 lib/
├── 📂 auth/                    # Halaman autentikasi
│   ├── login.dart
│   ├── register.dart
│   ├── forgot_password.dart
│   └── change_new_password.dart
│
├── 📂 components/              # Komponen UI reusable
│   ├── card_grafik.dart
│   ├── card_imunisasi.dart
│   ├── card_artikel.dart
│   └── navbottom.dart
│
├── 📂 controller/              # Controller bisnis
│   ├── auth_controller.dart
│   ├── jadwal_controller.dart
│   ├── imunisasi_controller.dart
│   ├── grafik_controller.dart
│   └── artikel_controller.dart
│
├── 📂 model/                   # Model data
│   └── user.dart
│
├── 📂 page/                    # Halaman utama
│   ├── dashboard_page.dart
│   ├── imunisasi.dart
│   ├── grafik.dart
│   ├── education.dart
│   └── userprofile.dart
│
└── main.dart                    # Entry point
```

---

## 🚀 Cara Menjalankan

### 1. Prerequisites
- Flutter SDK >= 3.9.2
- Dart SDK >= 3.0.0

### 2. Clone & Install

```bash
# Clone repository
git clone https://github.com/ardhikaxx/mobile-posyandu.git

# Masuk ke direktori
cd mobile-posyandu

# Install dependencies
flutter pub get
```

### 3. Run Aplikasi

```bash
# Jalankan aplikasi
flutter run
```

---

## 📸 Tampilan Aplikasi

| Splash Screen | Login | Dashboard |
|:-------------:|:-----:|:---------:|
| ![Splash] | ![Login] | ![Dashboard] |

---

## 📋 Requirements

- ✅ Flutter SDK >= 3.9.2
- ✅ Dart SDK >= 3.0.0
- ✅ Android SDK (untuk Android)
- ✅ Xcode (untuk iOS)

---

## 📄 Lisensi

Proyek ini dibuat untuk tujuan **educational**.

---

<div align="center">

**Made with ❤️ using Flutter**

</div>
