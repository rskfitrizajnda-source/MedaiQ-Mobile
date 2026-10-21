# MediQ Mobile

Aplikasi Android Flutter pendamping website [MediQ](https://github.com/rskfitrizajnda-source/MediQ).

## Status saat ini

UI awal berbahasa Indonesia dengan navigasi Beranda, Antrean, dan Profil. Data klinik dan nomor antrean masih **simulasi lokal**; aplikasi belum melakukan login, booking nyata, atau sinkronisasi realtime dengan backend website.

## Menjalankan di komputer

Persyaratan: Flutter SDK stabil dan Android SDK.

```bash
flutter pub get
flutter doctor
flutter run
```

Untuk perangkat Android via USB, aktifkan Developer options dan USB debugging, lalu cek:

```bash
flutter devices
flutter run
```

Membuat APK debug untuk pengujian:

```bash
flutter build apk --debug
```

APK berada di `build/app/outputs/flutter-apk/app-debug.apk`.

## Integrasi backend berikutnya

Backend MediQ website menggunakan Express, Socket.IO, Prisma, dan PostgreSQL. Sebelum mengaktifkan pendaftaran nyata:
1. Deploy backend ke URL HTTPS publik dan pastikan `/api/health` bisa diakses.
2. Audit endpoint autentikasi, klinik, layanan, dan antrean yang benar-benar tersedia di backend.
3. Implementasikan kontrak API yang sesuai di aplikasi mobile, termasuk token auth, error handling, dan realtime bila diperlukan.
4. Jangan memasukkan password database atau JWT secret backend ke aplikasi mobile. Rahasia hanya disimpan di environment backend.
5. Uji alur login, izin akses, validasi data, dan privasi sebelum memakai data pasien sungguhan.

## Struktur

- `lib/main.dart` — antarmuka dan navigasi Flutter.
- `pubspec.yaml` — dependensi aplikasi.
