import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:apip_market/main.dart';
import 'package:apip_market/utils/format.dart';

void main() {
  test('formatRupiah memberi titik ribuan', () {
    expect(formatRupiah(0), 'Rp 0');
    expect(formatRupiah(75000), 'Rp 75.000');
    expect(formatRupiah(2500000), 'Rp 2.500.000');
  });

  testWidgets('alur lengkap: masuk, klaim voucher, cek profile, keluar', (
    tester,
  ) async {
    // Pakai ukuran layar HP (360 x 780).
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const ApipMarketApp());

    // Halaman selamat datang.
    expect(find.text('Selamat datang di Apip Market'), findsOneWidget);
    await tester.tap(find.text('Masuk ke aplikasi'));
    await tester.pumpAndSettle();

    // Halaman store: buka produk Kaos Polos (Rp 75.000).
    expect(find.text('Kaos Polos'), findsOneWidget);
    await tester.tap(find.text('Kaos Polos'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada voucher'), findsOneWidget);
    expect(find.text('Rp 75.000'), findsOneWidget);

    // Klaim voucher 10% -> harga jadi Rp 67.500.
    await tester.tap(find.text('Klaim voucher diskon'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Diskon 10%'));
    await tester.pumpAndSettle();
    expect(find.text('Diskon 10%'), findsOneWidget);
    expect(find.text('Rp 67.500'), findsOneWidget);

    // Ganti ke voucher 20% -> harga jadi Rp 60.000.
    await tester.tap(find.text('Klaim voucher diskon'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Diskon 20%'));
    await tester.pumpAndSettle();
    expect(find.text('Rp 60.000'), findsOneWidget);

    // Kembali ke store lalu buka tab profile.
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profile').last);
    await tester.pumpAndSettle();

    expect(find.text('ghaisan apip'), findsOneWidget);
    expect(find.text('082XXXXXXXXX'), findsOneWidget);

    // Kode member awalnya tersembunyi, muncul saat diklik, hilang lagi
    // saat diklik ulang.
    expect(find.text('APM-2026-0812'), findsNothing);
    await tester.tap(find.text('Kode member'));
    await tester.pump();
    expect(find.text('APM-2026-0812'), findsOneWidget);
    await tester.tap(find.text('Kode member'));
    await tester.pump();
    expect(find.text('APM-2026-0812'), findsNothing);

    expect(find.text('Riwayat klaim voucher (2x)'), findsOneWidget);
    expect(find.text('Diskon 20% - Kaos Polos'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Diskon 10% - Kaos Polos'),
      100,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Diskon 10% - Kaos Polos'), findsOneWidget);

    // Keluar -> kembali ke halaman selamat datang.
    await tester.tap(find.text('Keluar'));
    await tester.pumpAndSettle();
    expect(find.text('Selamat datang di Apip Market'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });
}
