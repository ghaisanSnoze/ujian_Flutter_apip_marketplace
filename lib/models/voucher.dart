class Voucher {
  final String name;
  final int discountPercent;

  const Voucher({required this.name, required this.discountPercent});

  // Hitung harga setelah dipotong diskon voucher.
  int applyTo(int price) {
    return (price * (100 - discountPercent) / 100).round();
  }
}
