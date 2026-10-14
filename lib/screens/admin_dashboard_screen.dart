import 'package:flutter/material.dart';
import 'auth_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedTab = 0; // 0: Verifikasi Peminjaman, 1: Sakelar Maintenance, 2: Log Audit Staf
  String _selectedFilter = 'Pending';

  // Database Peminjaman Mahasiswa
  final List<Map<String, dynamic>> _allRequests = [
    {
      'id': 'REQ-101',
      'studentName': 'Syifa (Debong)',
      'nim': '25051204099',
      'facility': 'Studio Broadcast & Podcast UNESA',
      'location': 'Lantai 2 - Student Center',
      'timeSlot': '13:00 - 15:00 WIB',
      'date': '15/10/2026',
      'purpose': 'Take Rekaman Podcast UKM Media Kampus',
      'trustScore': 98,
      'status': 'Pending',
    },
    {
      'id': 'REQ-102',
      'studentName': 'Budi Prasetyo',
      'nim': '25051204102',
      'facility': 'Proyektor Portable BenQ 3000 Lumens',
      'location': 'Ruang Laboran Lt. 1',
      'timeSlot': '09:00 - 11:00 WIB',
      'date': '16/10/2026',
      'purpose': 'Presentasi Sidang Proposal Skripsi',
      'trustScore': 85,
      'status': 'Pending',
    },
    {
      'id': 'REQ-100',
      'studentName': 'Akhdan Farrel Bernadine',
      'nim': '25051204398',
      'facility': 'Lab Komputer Dasar 2',
      'location': 'Lantai 2 - Gedung Laboratorium',
      'timeSlot': '08:00 - 10:00 WIB',
      'date': '15/10/2026',
      'purpose': 'Praktikum Pemrograman Mobile Flutter',
      'trustScore': 95,
      'status': 'Approved',
    },
  ];

  // Database Sakelar Ketersediaan Fasilitas oleh Staf
  final List<Map<String, dynamic>> _managedFacilities = [
    {
      'name': 'Auditorium Utama Gedung A',
      'category': 'Ruangan',
      'location': 'Lantai 3 - Gedung Utama',
      'isAvailable': true,
      'note': 'Siap Dipinjam',
    },
    {
      'name': 'Lab Komputer Lanjut 1',
      'category': 'Ruangan',
      'location': 'Lantai 2 - Gedung Laboratorium',
      'isAvailable': false,
      'note': 'Sedang Pemeliharaan Jaringan LAN',
    },
    {
      'name': 'Studio Broadcast & Podcast UNESA',
      'category': 'Ruangan',
      'location': 'Lantai 2 - Student Center',
      'isAvailable': true,
      'note': 'Siap Dipinjam',
    },
    {
      'name': 'Proyektor Epson LCD Full HD',
      'category': 'Peralatan',
      'location': 'Ruang Laboran Lt. 1',
      'isAvailable': true,
      'note': 'Unit Ready',
    },
  ];

  // Database Log Audit Aktivitas Staf
  final List<Map<String, dynamic>> _auditLogs = [
    {
      'action': 'Persetujuan Peminjaman (ACC)',
      'detail': 'Menyetujui peminjaman Lab Komputer Dasar 2 oleh Akhdan Farrel',
      'time': 'Hari ini, 08:30 WIB',
      'icon': Icons.check_circle_rounded,
      'color': Colors.green,
    },
    {
      'action': 'Ubah Status Maintenance',
      'detail': 'Menonaktifkan Lab Komputer Lanjut 1 (Pemeliharaan Jaringan)',
      'time': 'Kemarin, 14:15 WIB',
      'icon': Icons.build_rounded,
      'color': Colors.orange,
    },
    {
      'action': 'Scan QR E-Pass Valid',
      'detail': 'Memverifikasi tiket digital mahasiswa atas nama Budi Prasetyo',
      'time': '12 Okt 2026, 09:10 WIB',
      'icon': Icons.qr_code_scanner_rounded,
      'color': Color(0xFF1E3A8A),
    },
  ];

  void _approveRequest(int index) {
    final item = _allRequests[index];
    setState(() {
      _allRequests[index]['status'] = 'Approved';
      // Tambahkan ke log audit otomatis
      _auditLogs.insert(0, {
        'action': 'Persetujuan Peminjaman (ACC)',
        'detail': 'Menyetujui peminjaman ${item['facility']} oleh ${item['studentName']}',
        'time': 'Baru saja',
        'icon': Icons.check_circle_rounded,
        'color': Colors.green,
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pengajuan ${item['studentName']} BERHASIL DISETUJUI!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _rejectRequest(int index) {
    final item = _allRequests[index];
    final TextEditingController reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.cancel_outlined, color: Colors.red),
              SizedBox(width: 8),
              Text('Tolak Pengajuan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          content: TextField(
            controller: reasonController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Masukkan alasan penolakan...',
              hintStyle: const TextStyle(fontSize: 12),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('BATAL', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _allRequests[index]['status'] = 'Rejected';
                  _auditLogs.insert(0, {
                    'action': 'Penolakan Peminjaman',
                    'detail': 'Menolak peminjaman ${item['facility']} oleh ${item['studentName']}',
                    'time': 'Baru saja',
                    'icon': Icons.cancel_rounded,
                    'color': Colors.red,
                  });
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pengajuan peminjaman telah ditolak.'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('KIRIM PENOLAKAN', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _showQRScannerModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner_rounded, color: Color(0xFF1E3A8A), size: 24),
                  SizedBox(width: 8),
                  Text('Pemindai Tiket Digital E-Pass', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              const Text('Arahkan kamera ke QR Code pada aplikasi mahasiswa', style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 20),
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.amber, width: 3),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.center_focus_weak_rounded, size: 80, color: Colors.amber),
                    SizedBox(height: 12),
                    Text('MENUNGGU QR CODE...', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF166534),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _auditLogs.insert(0, {
                        'action': 'Scan QR E-Pass Sukses',
                        'detail': 'Memverifikasi tiket digital mahasiswa di lokasi',
                        'time': 'Baru saja',
                        'icon': Icons.qr_code_scanner_rounded,
                        'color': const Color(0xFF1E3A8A),
                      });
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✅ TIKET VALID: Peminjaman Terverifikasi!'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.verified_rounded, size: 18),
                  label: const Text('SIMULASI SCAN BERHASIL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredRequests = _allRequests.where((item) {
      if (_selectedFilter == 'All') return true;
      return item['status'] == _selectedFilter;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Dashboard Verifikator / Laboran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            tooltip: 'Keluar Akun Staf',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showQRScannerModal,
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.qr_code_scanner_rounded, color: Colors.amber),
        label: const Text('SCAN QR TIKET', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.admin_panel_settings_rounded, size: 30, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Portal Kontrol Staf Kampus',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Kelola persetujuan, sakelar maintenance, dan audit log',
                          style: const TextStyle(fontSize: 12, color: Color(0xFF93C5FD)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // NAVIGASI 3 TAB UTAMA STAF
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedTab == 0 ? const Color(0xFF1E3A8A) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'ACC (${_allRequests.where((r) => r['status'] == 'Pending').length})',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: _selectedTab == 0 ? Colors.white : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedTab == 1 ? const Color(0xFF1E3A8A) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Sakelar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: _selectedTab == 1 ? Colors.white : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedTab == 2 ? const Color(0xFF1E3A8A) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Audit Log',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: _selectedTab == 2 ? Colors.white : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // TAB 0: VERIFIKASI PEMINJAMAN
            if (_selectedTab == 0) ...[
              Row(
                children: ['Pending', 'Approved', 'All'].map((status) {
                  final isSelected = _selectedFilter == status;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedFilter = status),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF0F172A) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF0F172A) : Colors.grey.shade300,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            status == 'Pending' ? 'Perlu ACC' : (status == 'Approved' ? 'Disetujui' : 'Semua'),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              filteredRequests.isEmpty
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.check_circle_outline_rounded, size: 48, color: Colors.green),
                          SizedBox(height: 12),
                          Text('Tidak ada pengajuan pada kategori ini', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredRequests.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final item = filteredRequests[index];
                        final bool isPending = item['status'] == 'Pending';

                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item['id'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isPending ? Colors.amber.withAlpha(30) : Colors.green.withAlpha(30),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item['status'],
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: isPending ? const Color(0xFF78350F) : Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(item['studentName'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                              Text('NIM: ${item['nim']} • Trust Score: ${item['trustScore']} Poin', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              const Divider(height: 20),
                              Text(item['facility'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('${item['date']} • Slot: ${item['timeSlot']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              const SizedBox(height: 4),
                              Text('Keperluan: ${item['purpose']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              if (isPending) ...[
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.red,
                                          side: const BorderSide(color: Colors.red),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        ),
                                        onPressed: () => _rejectRequest(index),
                                        child: const Text('TOLAK', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF166534),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        ),
                                        onPressed: () => _approveRequest(index),
                                        child: const Text('SETUJU (ACC)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
            ],

            // TAB 1: SAKELAR KONTROL MAINTENANCE
            if (_selectedTab == 1) ...[
              const Text('Kontrol Ketersediaan Fasilitas Real-Time', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(height: 4),
              const Text('Matikan sakelar jika ruangan/barang sedang dalam perbaikan.', style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _managedFacilities.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final fac = _managedFacilities[index];
                  final bool isAvailable = fac['isAvailable'];

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isAvailable ? Colors.grey.shade200 : Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: isAvailable ? Colors.green.withAlpha(20) : Colors.red.withAlpha(20),
                          child: Icon(isAvailable ? Icons.check_circle_rounded : Icons.build_circle_rounded, color: isAvailable ? Colors.green : Colors.red),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(fac['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text('${fac['category']} • ${fac['location']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              const SizedBox(height: 4),
                              Text(isAvailable ? 'Status: Siap Dipinjam' : 'Status: Maintenance', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isAvailable ? Colors.green : Colors.red)),
                            ],
                          ),
                        ),
                        Switch(
                          value: isAvailable,
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.red,
                          onChanged: (val) {
                            setState(() {
                              _managedFacilities[index]['isAvailable'] = val;
                              _auditLogs.insert(0, {
                                'action': 'Ubah Status Sakelar',
                                'detail': '${fac['name']} diubah menjadi ${val ? "Aktif" : "Maintenance"}',
                                'time': 'Baru saja',
                                'icon': Icons.build_rounded,
                                'color': Colors.orange,
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],

            // TAB 2: AUDIT LOG AKTIVITAS STAF
            if (_selectedTab == 2) ...[
              const Text('Riwayat Audit & Aktivitas Staf', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(height: 4),
              const Text('Rekam jejak tindakan verifikasi dan kontrol yang dilakukan oleh staf/laboran.', style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _auditLogs.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final log = _auditLogs[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: log['color'].withAlpha(20),
                          child: Icon(log['icon'], color: log['color'], size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(log['action'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 2),
                              Text(log['detail'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              const SizedBox(height: 4),
                              Text(log['time'], style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}