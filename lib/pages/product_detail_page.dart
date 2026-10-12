import 'package:flutter/material.dart';

import '../data/claim_history.dart';
import '../models/product.dart';
import '../models/voucher.dart';
import '../utils/format.dart';
import 'voucher_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Voucher? _voucher;

  Future<void> _openVoucherPage() async {
    // Tunggu voucher yang dipilih dari halaman voucher (null kalau user
    // menekan tombol back tanpa memilih).
    final selected = await Navigator.push<Voucher>(
      context,
      MaterialPageRoute(builder: (_) => VoucherPage(currentVoucher: _voucher)),
    );

    if (selected == null || !mounted) return;

    claimHistory.addClaim(widget.product, selected);
    setState(() => _voucher = selected);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final voucher = _voucher;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Icon(product.icon, size: 140, color: colors.primary),
          const SizedBox(height: 24),
          Text(
            product.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          if (voucher != null)
            Text(
              formatRupiah(product.price),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: colors.outline,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          Text(
            formatRupiah(
              voucher == null ? product.price : voucher.applyTo(product.price),
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.confirmation_number),
              title: const Text('Voucher'),
              subtitle: Text(voucher?.name ?? 'Belum ada voucher'),
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: _openVoucherPage,
            icon: const Icon(Icons.local_offer),
            label: const Text('Klaim voucher diskon'),
          ),
        ],
      ),
    );
  }
}
