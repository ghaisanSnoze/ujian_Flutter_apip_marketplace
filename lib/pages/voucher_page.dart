import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/voucher.dart';

class VoucherPage extends StatelessWidget {
  // Voucher yang sedang dipakai, supaya bisa ditandai di daftar.
  final Voucher? currentVoucher;

  const VoucherPage({super.key, this.currentVoucher});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Klaim Voucher')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: vouchers.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final voucher = vouchers[index];
          final isUsed =
              voucher.discountPercent == currentVoucher?.discountPercent;

          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: colors.primaryContainer,
                child: Text(
                  '${voucher.discountPercent}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ),
              title: Text(
                voucher.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Potongan ${voucher.discountPercent}% dari harga produk',
              ),
              trailing: isUsed
                  ? Icon(Icons.check_circle, color: colors.primary)
                  : const Icon(Icons.chevron_right),
              // Kirim voucher yang dipilih balik ke halaman produk.
              onTap: () => Navigator.pop(context, voucher),
            ),
          );
        },
      ),
    );
  }
}
