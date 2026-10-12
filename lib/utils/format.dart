// Ubah angka jadi format Rupiah, contoh: 150000 -> "Rp 150.000".
String formatRupiah(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[i]);
  }
  return 'Rp $buffer';
}

// Ubah waktu jadi format "12/10/2026 08:05".
String formatDateTime(DateTime time) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return '${twoDigits(time.day)}/${twoDigits(time.month)}/${time.year} '
      '${twoDigits(time.hour)}:${twoDigits(time.minute)}';
}
