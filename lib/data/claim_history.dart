import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../models/voucher.dart';

class ClaimRecord {
  final Product product;
  final Voucher voucher;
  final DateTime time;

  const ClaimRecord({
    required this.product,
    required this.voucher,
    required this.time,
  });
}

// Menyimpan riwayat klaim voucher supaya bisa dibaca dari halaman profile.
// Pakai ChangeNotifier bawaan Flutter, jadi tidak perlu package tambahan.
class ClaimHistory extends ChangeNotifier {
  final List<ClaimRecord> _records = [];

  List<ClaimRecord> get records => List.unmodifiable(_records);

  int get totalClaims => _records.length;

  void addClaim(Product product, Voucher voucher) {
    // Riwayat terbaru ditaruh paling atas.
    _records.insert(
      0,
      ClaimRecord(product: product, voucher: voucher, time: DateTime.now()),
    );
    notifyListeners();
  }
}

final claimHistory = ClaimHistory();
