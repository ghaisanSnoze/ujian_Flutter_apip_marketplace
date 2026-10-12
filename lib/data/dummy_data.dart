import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/voucher.dart';

// Data user untuk halaman profile.
const String username = 'ghaisan apip';
const String memberCode = 'APM-2026-0812';
const String phoneNumber = '082XXXXXXXXX';

const List<Product> products = [
  Product(name: 'Kaos Polos', price: 75000, icon: Icons.checkroom),
  Product(name: 'Headphone', price: 250000, icon: Icons.headphones),
  Product(name: 'Jam Tangan', price: 350000, icon: Icons.watch),
  Product(name: 'Tas Ransel', price: 180000, icon: Icons.backpack),
  Product(name: 'Mouse Wireless', price: 95000, icon: Icons.mouse),
  Product(name: 'Smartphone', price: 2500000, icon: Icons.smartphone),
];

const List<Voucher> vouchers = [
  Voucher(name: 'Diskon 10%', discountPercent: 10),
  Voucher(name: 'Diskon 20%', discountPercent: 20),
];
