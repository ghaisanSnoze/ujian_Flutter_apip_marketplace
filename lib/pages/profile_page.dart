import 'package:flutter/material.dart';

import '../data/claim_history.dart';
import '../data/dummy_data.dart';
import '../utils/format.dart';
import 'welcome_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Kode member disembunyikan dulu, baru muncul setelah diklik.
  bool _showMemberCode = false;

  void _logout() {
    // Hapus semua halaman sebelumnya lalu kembali ke halaman selamat datang.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const WelcomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Semua isi profile bisa di-scroll, jadi riwayat yang panjang
            // tetap muat di layar HP yang kecil.
            Expanded(
              child: ListenableBuilder(
                // Rebuild otomatis setiap ada klaim voucher baru.
                listenable: claimHistory,
                builder: (context, _) {
                  final records = claimHistory.records;

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: colors.primary,
                          child: Icon(
                            Icons.store,
                            size: 52,
                            color: colors.onPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        username,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.card_membership),
                              title: const Text('Kode member'),
                              subtitle: Text(
                                _showMemberCode
                                    ? memberCode
                                    : '•' * memberCode.length,
                              ),
                              trailing: Icon(
                                _showMemberCode
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onTap: () {
                                setState(
                                  () => _showMemberCode = !_showMemberCode,
                                );
                              },
                            ),
                            const ListTile(
                              leading: Icon(Icons.phone),
                              title: Text('No. telepon'),
                              subtitle: Text(phoneNumber),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Riwayat klaim voucher (${claimHistory.totalClaims}x)',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (records.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            'Belum ada voucher yang diklaim',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: colors.outline),
                          ),
                        ),
                      for (final record in records)
                        ListTile(
                          dense: true,
                          leading: const Icon(
                            Icons.confirmation_number_outlined,
                          ),
                          title: Text(
                            '${record.voucher.name} - ${record.product.name}',
                          ),
                          subtitle: Text(formatDateTime(record.time)),
                        ),
                    ],
                  );
                },
              ),
            ),
            // Tombol keluar selalu di paling bawah, tidak ikut ter-scroll.
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: OutlinedButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout),
                label: const Text('Keluar'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.error,
                  side: BorderSide(color: colors.error),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
