# Mobile Posyandu

Aplikasi mobile Posyandu (Pos Layanan Terpadu) untuk membantu ibu dalam memantau kesehatan dan perkembangan anak. Aplikasi ini memungkinkan ibu untuk melihat jadwal posyandu, mencatat imunisasi, memantau pertumbuhan anak melalui grafik, dan mengakses artikel edukasi kesehatan.

## Fitur

### 1. Autentikasi
- **Login** - Masuk ke aplikasi dengan akun yang terdaftar
- **Register** - Mendaftarkan akun baru
- **Lupa Password** - Mengatur ulang kata sandi
- **Ganti Password** - Mengubah kata sandi akun

### 2. Dashboard
- Menampilkan pesan selamat datang dengan nama ibu
- Melihat jadwal posyandu bulan ini
- Melihat data perkembangan anak (berat badan dan tinggi badan)
- Indikator tren perkembangan (naik, turun, stabil)

### 3. Imunisasi
- Melihat riwayat imunisasi anak
- Informasi jadwal imunisasi lengkap
- Detail imunisasi masing-masing anak

### 4. Grafik Pertumbuhan
- Grafik pertumbuhan berat badan anak
- Grafik pertumbuhan tinggi badan anak
- Visualisasi data posyandu

### 5. Edukasi
- Artikel kesehatan ibu dan anak
- Tips perawatan kesehatan
- Informasi tentang tumbuh kembang anak

### 6. Profil Pengguna
- Melihat data profil
- Mengedit informasi profil

## Teknologi yang Digunakan

- **Flutter** - Framework cross-platform untuk pengembangan mobile
- **Dart** - Bahasa pemrograman
- **GetX** - State management dan routing
- **Dio** - HTTP client untuk API
- **Syncfusion Flutter Charts** - Untukvisualisasi grafik pertumbuhan
- **SQLite** - Local database
- **Shared Preferences** - Penyimpanan data lokal

## Struktur Proyek

```
lib/
├── auth/               # Halaman autentikasi
│   ├── login.dart
│   ├── register.dart
│   ├── forgot_password.dart
│   └── change_new_password.dart
├── components/         # Komponen UI yang dapat digunakan ulang
│   ├── card_grafik.dart
│   ├── card_imunisasi.dart
│   ├── card_artikel.dart
│   └── navbottom.dart
├── controller/         # Controller untuk logika bisnis
│   ├── auth_controller.dart
│   ├── jadwal_controller.dart
│   ├── imunisasi_controller.dart
│   ├── grafik_controller.dart
│   └── artikel_controller.dart
├── model/              # Model data
│   └── user.dart
├── page/               # Halaman utama aplikasi
│   ├── dashboard_page.dart
│   ├── imunisasi.dart
│   ├── grafik.dart
│   ├── education.dart
│   └── userprofile.dart
└── main.dart           # Entry point aplikasi
```

## Cara Menjalankan

1. Pastikan Flutter SDK sudah terinstall
2. Clone repository ini
3. Jalankan perintah berikut:

```bash
# Install dependencies
flutter pub get

# Jalankan aplikasi
flutter run
```

## Requirements

- Flutter SDK >= 3.9.2
- Dart SDK >= 3.0.0

## Lisensi

Proyek ini dibuat untuk tujuan educational.
