import 'package:flutter/material.dart';

class FloorPlanPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onBook;

  const FloorPlanPage({super.key, required this.onBook});

  @override
  State<FloorPlanPage> createState() => _FloorPlanPageState();
}

class _FloorPlanPageState extends State<FloorPlanPage> {
  String _selectedBuilding = 'Gedung A (Utama)';
  int _selectedFloor = 3;

  // Database Denah Ruangan Lengkap per Gedung & Lantai
  final Map<String, Map<int, List<Map<String, dynamic>>>> _buildingData = {
    'Gedung A (Utama)': {
      1: [
        {
          'id': 'A101',
          'title': 'Lobi Utama & Pusat Informasi',
          'location': 'Lantai 1 - Gedung A',
          'capacity': '100 Orang',
          'status': 'occupied',
          'icon': Icons.info_outline_rounded,
        },
        {
          'id': 'A102',
          'title': 'Ruang Kuliah Teori A.102',
          'location': 'Lantai 1 - Gedung A',
          'capacity': '60 Kursi',
          'status': 'available',
          'icon': Icons.class_rounded,
        },
        {
          'id': 'A103',
          'title': 'Ruang Pelayanan Tata Usaha',
          'location': 'Lantai 1 - Gedung A',
          'capacity': '15 Orang',
          'status': 'occupied',
          'icon': Icons.badge_outlined,
        },
        {
          'id': 'A104',
          'title': 'Ruang Rapat Dekanat',
          'location': 'Lantai 1 - Gedung A',
          'capacity': '30 Orang',
          'status': 'pending',
          'icon': Icons.groups_rounded,
        },
      ],
      2: [
        {
          'id': 'A201',
          'title': 'Ruang Dosen Teknik Informatika',
          'location': 'Lantai 2 - Gedung A',
          'capacity': '40 Dosen',
          'status': 'occupied',
          'icon': Icons.work_outline_rounded,
        },
        {
          'id': 'A202',
          'title': 'Ruang Kuliah Teori A.202',
          'location': 'Lantai 2 - Gedung A',
          'capacity': '50 Kursi',
          'status': 'available',
          'icon': Icons.class_rounded,
        },
        {
          'id': 'A203',
          'title': 'Ruang Kuliah Teori A.203',
          'location': 'Lantai 2 - Gedung A',
          'capacity': '50 Kursi',
          'status': 'available',
          'icon': Icons.class_rounded,
        },
        {
          'id': 'A204',
          'title': 'Ruang Sidang Skripsi 1',
          'location': 'Lantai 2 - Gedung A',
          'capacity': '15 Orang',
          'status': 'pending',
          'icon': Icons.assignment_turned_in_rounded,
        },
      ],
      3: [
        {
          'id': 'A301',
          'title': 'Auditorium Utama Gedung A',
          'location': 'Lantai 3 - Gedung A',
          'capacity': '300 Orang',
          'status': 'available',
          'icon': Icons.account_balance_rounded,
        },
        {
          'id': 'A302',
          'title': 'Ruang Rapat Senat Kampus',
          'location': 'Lantai 3 - Gedung A',
          'capacity': '25 Orang',
          'status': 'occupied',
          'icon': Icons.groups_rounded,
        },
        {
          'id': 'A303',
          'title': 'Ruang Seminar 1',
          'location': 'Lantai 3 - Gedung A',
          'capacity': '60 Orang',
          'status': 'available',
          'icon': Icons.meeting_room_rounded,
        },
        {
          'id': 'A304',
          'title': 'Ruang VIP Guest Lounge',
          'location': 'Lantai 3 - Gedung A',
          'capacity': '20 Orang',
          'status': 'pending',
          'icon': Icons.weekend_rounded,
        },
      ],
    },
    'Gedung Laboratorium': {
      1: [
        {
          'id': 'LAB101',
          'title': 'Ruang Staf Laboran & Aset',
          'location': 'Lantai 1 - Gedung Lab',
          'capacity': '10 Staf',
          'status': 'occupied',
          'icon': Icons.admin_panel_settings_rounded,
        },
        {
          'id': 'LAB102',
          'title': 'Lab Hardware & Microcontroller',
          'location': 'Lantai 1 - Gedung Lab',
          'capacity': '30 Kursi',
          'status': 'available',
          'icon': Icons.developer_board_rounded,
        },
        {
          'id': 'LAB103',
          'title': 'Gudang Penyimpanan Peralatan',
          'location': 'Lantai 1 - Gedung Lab',
          'capacity': 'Kapasitas Penuh',
          'status': 'occupied',
          'icon': Icons.inventory_rounded,
        },
        {
          'id': 'LAB104',
          'title': 'Lab Fisika & Elektronika Dasar',
          'location': 'Lantai 1 - Gedung Lab',
          'capacity': '35 Kursi',
          'status': 'available',
          'icon': Icons.science_rounded,
        },
      ],
      2: [
        {
          'id': 'LAB201',
          'title': 'Lab Komputer Lanjut 1',
          'location': 'Lantai 2 - Gedung Lab',
          'capacity': '40 Kursi',
          'status': 'occupied',
          'icon': Icons.laptop_chromebook_rounded,
        },
        {
          'id': 'LAB202',
          'title': 'Lab Komputer Dasar 2',
          'location': 'Lantai 2 - Gedung Lab',
          'capacity': '35 Kursi',
          'status': 'available',
          'icon': Icons.desktop_windows_rounded,
        },
        {
          'id': 'LAB203',
          'title': 'Lab Multimedia & Desain Grafis',
          'location': 'Lantai 2 - Gedung Lab',
          'capacity': '30 Kursi',
          'status': 'available',
          'icon': Icons.palette_rounded,
        },
        {
          'id': 'LAB204',
          'title': 'Studio Video & Render Farm',
          'location': 'Lantai 2 - Gedung Lab',
          'capacity': '15 Kursi',
          'status': 'pending',
          'icon': Icons.movie_creation_rounded,
        },
      ],
      3: [
        {
          'id': 'LAB301',
          'title': 'Lab Jaringan & Cyber Security',
          'location': 'Lantai 3 - Gedung Lab',
          'capacity': '30 Kursi',
          'status': 'available',
          'icon': Icons.hub_rounded,
        },
        {
          'id': 'LAB302',
          'title': 'Lab Kecerdasan Buatan (AI)',
          'location': 'Lantai 3 - Gedung Lab',
          'capacity': '25 Kursi',
          'status': 'occupied',
          'icon': Icons.psychology_rounded,
        },
        {
          'id': 'LAB303',
          'title': 'Lab Rekayasa Perangkat Lunak',
          'location': 'Lantai 3 - Gedung Lab',
          'capacity': '35 Kursi',
          'status': 'available',
          'icon': Icons.code_rounded,
        },
        {
          'id': 'LAB304',
          'title': 'Ruang Riset Mahasiswa & Dosen',
          'location': 'Lantai 3 - Gedung Lab',
          'capacity': '20 Kursi',
          'status': 'available',
          'icon': Icons.biotech_rounded,
        },
      ],
    },
    'Gedung Student Center': {
      1: [
        {
          'id': 'SC101',
          'title': 'Co-Working Space UKM',
          'location': 'Lantai 1 - Student Center',
          'capacity': '50 Orang',
          'status': 'available',
          'icon': Icons.door_sliding_rounded,
        },
        {
          'id': 'SC102',
          'title': 'Kantor Sekretariat BEM',
          'location': 'Lantai 1 - Student Center',
          'capacity': '20 Orang',
          'status': 'occupied',
          'icon': Icons.diversity_3_rounded,
        },
        {
          'id': 'SC103',
          'title': 'Kantin & Area Bisnis Mahasiswa',
          'location': 'Lantai 1 - Student Center',
          'capacity': '80 Orang',
          'status': 'available',
          'icon': Icons.storefront_rounded,
        },
        {
          'id': 'SC104',
          'title': 'Ruang Diskusi Terbuka A',
          'location': 'Lantai 1 - Student Center',
          'capacity': '25 Orang',
          'status': 'pending',
          'icon': Icons.forum_rounded,
        },
      ],
      2: [
        {
          'id': 'SC201',
          'title': 'Studio Broadcast & Podcast UNESA',
          'location': 'Lantai 2 - Student Center',
          'capacity': '10 Orang',
          'status': 'occupied',
          'icon': Icons.mic_external_on_rounded,
        },
        {
          'id': 'SC202',
          'title': 'Ruang Latihan Musik / Band',
          'location': 'Lantai 2 - Student Center',
          'capacity': '12 Orang',
          'status': 'available',
          'icon': Icons.music_note_rounded,
        },
        {
          'id': 'SC203',
          'title': 'Ruang Sekretariat UKM Robotik',
          'location': 'Lantai 2 - Student Center',
          'capacity': '15 Orang',
          'status': 'available',
          'icon': Icons.smart_toy_rounded,
        },
        {
          'id': 'SC204',
          'title': 'Ruang Latihan Tari & Seni',
          'location': 'Lantai 2 - Student Center',
          'capacity': '30 Orang',
          'status': 'pending',
          'icon': Icons.theater_comedy_rounded,
        },
      ],
      3: [
        {
          'id': 'SC301',
          'title': 'Hall Bulutangkis & Serbaguna',
          'location': 'Lantai 3 - Student Center',
          'capacity': '150 Orang',
          'status': 'available',
          'icon': Icons.sports_tennis_rounded,
        },
        {
          'id': 'SC302',
          'title': 'Area Tenis Meja & Catur',
          'location': 'Lantai 3 - Student Center',
          'capacity': '30 Orang',
          'status': 'available',
          'icon': Icons.sports_esports_rounded,
        },
        {
          'id': 'SC303',
          'title': 'Ruang Fitness / Gym Mahasiswa',
          'location': 'Lantai 3 - Student Center',
          'capacity': '20 Orang',
          'status': 'occupied',
          'icon': Icons.fitness_center_rounded,
        },
        {
          'id': 'SC304',
          'title': 'Gudang Perlengkapan Olahraga',
          'location': 'Lantai 3 - Student Center',
          'capacity': 'Kapasitas Penuh',
          'status': 'occupied',
          'icon': Icons.inventory_2_rounded,
        },
      ],
    },
  };

  Color _getStatusColor(String status) {
    switch (status) {
      case 'available':
        return const Color(0xFF22C55E);
      case 'occupied':
        return const Color(0xFFEF4444);
      case 'pending':
        return const Color(0xFFF59E0B);
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'available':
        return 'Tersedia';
      case 'occupied':
        return 'Sedang Terpakai';
      case 'pending':
        return 'Menunggu Verifikasi';
      default:
        return 'Tidak Aktif';
    }
  }

  void _showRoomDetailsModal(Map<String, dynamic> room) {
    final bool isAvailable = room['status'] == 'available';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(room['status']).withAlpha(30),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getStatusText(room['status']),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(room['status']),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                room['title'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Kode Ruang: ${room['id']} • ${room['location']}',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.people_alt_outlined, color: Color(0xFF1E3A8A), size: 20),
                  const SizedBox(width: 8),
                  Text('Kapasitas: ${room['capacity']}', style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAvailable ? const Color(0xFF1E3A8A) : Colors.grey.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: isAvailable
                      ? () {
                          Navigator.pop(context);
                          widget.onBook(room);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Mengajukan peminjaman ${room['title']}'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.bookmark_add_rounded, size: 20),
                  label: Text(
                    isAvailable ? 'AJUKAN PEMINJAMAN' : 'RUANGAN TIDAK TERSEDIA',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
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
    final List<Map<String, dynamic>> currentRooms =
        _buildingData[_selectedBuilding]?[_selectedFloor] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Denah Interaktif Kampus', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown Selector Gedung & Lantai
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedBuilding,
                        decoration: const InputDecoration(
                          labelText: 'Pilih Gedung',
                          border: InputBorder.none,
                        ),
                        items: ['Gedung A (Utama)', 'Gedung Laboratorium', 'Gedung Student Center']
                            .map((b) => DropdownMenuItem(value: b, child: Text(b, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold))))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedBuilding = val!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _selectedFloor,
                        decoration: const InputDecoration(
                          labelText: 'Pilih Lantai',
                          border: InputBorder.none,
                        ),
                        items: [1, 2, 3]
                            .map((f) => DropdownMenuItem(value: f, child: Text('Lantai $f', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold))))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedFloor = val!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Indikator Legenda Warna Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem('Tersedia', const Color(0xFF22C55E)),
                _buildLegendItem('Terpakai', const Color(0xFFEF4444)),
                _buildLegendItem('Menunggu', const Color(0xFFF59E0B)),
              ],
            ),
            const SizedBox(height: 20),

            // Judul Laying Out Dinamis
            Text(
              'Layout Dinamis: $_selectedBuilding - Lantai $_selectedFloor',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),

            // GRID CANVAS PETA DINAMIS
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade300, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(8),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Koridor Utama Sesuai Lantai
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '--- KORIDOR UTAMA LANTAI $_selectedFloor ---',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Grid Render Ruangan Sesuai Pilihan Gedung & Lantai
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: currentRooms.length,
                    itemBuilder: (context, index) {
                      final room = currentRooms[index];
                      final color = _getStatusColor(room['status']);

                      return InkWell(
                        onTap: () => _showRoomDetailsModal(room),
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: color.withAlpha(20),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: color, width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(room['icon'], color: color, size: 28),
                              const SizedBox(height: 6),
                              Text(
                                room['id'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: color,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                room['title'],
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}