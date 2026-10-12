# Apip Market — Ujian Flutter

Aplikasi online shop sederhana untuk ujian mobile programming, kelas XI RPL.

## Fitur
- **Welcome**: halaman selamat datang dengan tombol "Masuk ke aplikasi".
  Setelah masuk, tombol back nggak balik lagi ke halaman ini.
- **Store**: grid 6 produk (Kaos Polos, Headphone, Jam Tangan, Tas Ransel, Mouse Wireless,
  Smartphone) lengkap dengan ikon dan harga format Rupiah. Tap produk buat buka detailnya.
- **Detail Produk**: tombol "Klaim voucher diskon" buka halaman voucher (Diskon 10% / 20%).
  Setelah voucher dipilih, harga lama dicoret dan harga baru langsung muncul.
- **Profile**: nama user, kode member (tap buat tampilkan / sembunyikan), no. telepon,
  riwayat klaim voucher (jumlah + waktu klaim, update otomatis), dan tombol **Keluar**
  yang balik ke halaman Welcome.
- Bottom navigation Store / Profile pakai `IndexedStack`, jadi posisi scroll tiap tab nggak ke-reset.

## Struktur Folder
```
lib/
├── main.dart                     # tema + entry point
├── models/
│   ├── product.dart
│   └── voucher.dart              # hitung harga setelah diskon
├── data/
│   ├── dummy_data.dart           # data user, produk, voucher
│   └── claim_history.dart        # riwayat klaim (ChangeNotifier)
├── utils/format.dart             # format Rupiah & tanggal
└── pages/
    ├── welcome_page.dart
    ├── home_page.dart            # bottom nav + ganti tab
    ├── store_page.dart
    ├── product_detail_page.dart
    ├── voucher_page.dart
    └── profile_page.dart
```

## Cara Menjalankan
```bash
flutter pub get
flutter run
```

## Testing
```bash
flutter test
```
Ada test format Rupiah dan test alur lengkap: masuk → buka produk → klaim voucher 10% lalu 20%
→ cek harga → cek profile & riwayat klaim → keluar.

## Screenshot
| Welcome | Store | Detail Produk | Voucher | Profile |
|---------|-------|---------------|---------|---------|
| _(screenshot)_ | _(screenshot)_ | _(screenshot)_ | _(screenshot)_ | _(screenshot)_ |
