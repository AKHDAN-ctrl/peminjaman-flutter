import 'package:flutter/material.dart';
import 'floor_plan_screen.dart';
import 'booking_timeline_screen.dart';
import 'notifications_screen.dart';

class CatalogPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onBook;
  final String userId;
  final String userEmail;

  const CatalogPage({
    super.key,
    required this.onBook,
    required this.userId,
    required this.userEmail,
  });

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  int _selectedCategory = 0; // 0: Ruangan Kampus, 1: Barang / Fasilitas
  String _searchQuery = '';

  final List<Map<String, dynamic>> _rooms = [
    {
      'title': 'Auditorium Utama Gedung A',
      'location': 'Lantai 3 - Gedung Utama',
      'capacity': '300 Orang',
      'icon': Icons.account_balance_rounded,
      'isAvailable': true,
      'tag': 'Gedung A',
    },
    {
      'title': 'Lab Komputer Lanjut 1',
      'location': 'Lantai 2 - Gedung Laboratorium',
      'capacity': '40 Kursi',
      'icon': Icons.laptop_chromebook_rounded,
      'isAvailable': false,
      'tag': 'Lab Terintegrasi',
    },
    {
      'title': 'Lab Komputer Dasar 2',
      'location': 'Lantai 2 - Gedung Laboratorium',
      'capacity': '35 Kursi',
      'icon': Icons.desktop_windows_rounded,
      'isAvailable': true,
      'tag': 'Lab Terintegrasi',
    },
    {
      'title': 'Lab Jaringan & Cyber Security',
      'location': 'Lantai 3 - Gedung Laboratorium',
      'capacity': '30 Kursi',
      'icon': Icons.hub_rounded,
      'isAvailable': true,
      'tag': 'Lab Siber',
    },
    {
      'title': 'Ruang Rapat Senat Kampus',
      'location': 'Lantai 1 - Rektorat',
      'capacity': '25 Orang',
      'icon': Icons.groups_rounded,
      'isAvailable': true,
      'tag': 'Rektorat',
    },
    {
      'title': 'Co-Working Space UKM',
      'location': 'Gedung Student Center Lt. 1',
      'capacity': '50 Orang',
      'icon': Icons.door_sliding_rounded,
      'isAvailable': true,
      'tag': 'Student Center',
    },
    {
      'title': 'Ruang Kuliah Teori A.102',
      'location': 'Lantai 1 - Gedung Kuliah Bersama',
      'capacity': '60 Kursi',
      'icon': Icons.class_rounded,
      'isAvailable': true,
      'tag': 'GKB Lt.1',
    },
  ];

  final List<Map<String, dynamic>> _assets = [
    {
      'title': 'Proyektor Epson LCD Full HD',
      'location': 'Ruang Laboran Lt. 1',
      'capacity': 'Unit #01',
      'icon': Icons.videocam_rounded,
      'isAvailable': true,
      'tag': 'Multimedia',
    },
    {
      'title': 'Sound System Portable + 2 Mic Wireless',
      'location': 'Gedung Student Center',
      'capacity': 'Set #01',
      'icon': Icons.speaker_group_rounded,
      'isAvailable': true,
      'tag': 'Audio',
    },
    {
      'title': 'Kamera DSLR Canon EOS 80D',
      'location': 'Studio Multimedia Lt. 2',
      'capacity': 'Unit #03',
      'icon': Icons.camera_alt_rounded,
      'isAvailable': true,
      'tag': 'Dokumentasi',
    },
    {
      'title': 'Kabel Roll Listrik Heavy Duty 25 Meter',
      'location': 'Gudang Perlengkapan BEM',
      'capacity': '5 Unit Tersedia',
      'icon': Icons.electrical_services_rounded,
      'isAvailable': true,
      'tag': 'Perlengkapan',
    },
  ];

  void _showAIChatbotSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AIChatbotModal(onBook: widget.onBook);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentList = _selectedCategory == 0 ? _rooms : _assets;
    final filteredList = currentList.where((item) {
      final title = item['title'].toString().toLowerCase();
      final location = item['location'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query) || location.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAIChatbotSheet,
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 6,
        icon: const Icon(Icons.smart_toy_rounded, color: Colors.amber),
        label: const Text(
          'Tanya AI Asisten',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // 🧲 PARALLAX SLIVER APP BAR (HEADER MENYUSUT & MELAYANG HALUS)
              SliverAppBar(
                expandedHeight: 220.0,
                floating: false,
                pinned: true,
                elevation: 0,
                backgroundColor: const Color(0xFF0F172A),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    padding: const EdgeInsets.only(top: 64, bottom: 20, left: 20, right: 20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0F172A), Color(0xFF1E3A8A), Color(0xFF2563EB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.amber, width: 2),
                              ),
                              child: const CircleAvatar(
                                radius: 24,
                                backgroundImage: AssetImage('assets/profile.png'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Akhdan Farrel Bernadine',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Icon(Icons.school_rounded, size: 14, color: Color(0xFF93C5FD)),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Mahasiswa Aktif • NIM ${widget.userId.isEmpty ? "25051204398" : widget.userId}',
                                        style: const TextStyle(fontSize: 12, color: Color(0xFF93C5FD)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // TOMBOL DENAH PETA RUANGAN
                            Container(
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(30),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.map_outlined, color: Colors.white, size: 22),
                                tooltip: 'Lihat Denah Ruangan',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FloorPlanPage(onBook: widget.onBook),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // TOMBOL NOTIFIKASI
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(30),
                                  shape: BoxShape.circle,
                                ),
                                child: const Stack(
                                  children: [
                                    Icon(Icons.notifications_active_outlined, color: Colors.white, size: 22),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: CircleAvatar(
                                        radius: 4,
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildQuickStatCard('${_rooms.length}', 'Ruangan', Icons.door_front_door_outlined),
                            const SizedBox(width: 10),
                            _buildQuickStatCard(
                              '${_rooms.where((r) => r['isAvailable']).length + _assets.where((a) => a['isAvailable']).length}',
                              'Tersedia',
                              Icons.check_circle_outline_rounded,
                            ),
                            const SizedBox(width: 10),
                            _buildQuickStatCard('${_assets.length}', 'Peralatan', Icons.inventory_2_outlined),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 📄 KONTEN KATALOG UTAMA
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(10),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              _searchQuery = val;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: _selectedCategory == 0 ? 'Cari nama/lokasi ruangan...' : 'Cari alat / fasilitas kampus...',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                            prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF1E3A8A)),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear_rounded, size: 20),
                                    onPressed: () => setState(() => _searchQuery = ''),
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedCategory = 0),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: _selectedCategory == 0 ? const Color(0xFF1E3A8A) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.meeting_room_rounded, size: 18, color: _selectedCategory == 0 ? Colors.white : Colors.grey),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Ruangan (${_rooms.length})',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: _selectedCategory == 0 ? Colors.white : Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedCategory = 1),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: _selectedCategory == 1 ? const Color(0xFF1E3A8A) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.inventory_2_rounded, size: 18, color: _selectedCategory == 1 ? Colors.white : Colors.grey),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Peralatan (${_assets.length})',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: _selectedCategory == 1 ? Colors.white : Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedCategory == 0 ? 'Daftar Ruangan Kampus' : 'Daftar Peralatan & Aset',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                          ),
                          Text(
                            '${filteredList.length} Item',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF2563EB)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredList.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = filteredList[index];
                          final bool isAvailable = item['isAvailable'];

                          return Container(
                            padding: const EdgeInsets.all(14.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFF6FF),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(item['icon'], color: const Color(0xFF1E3A8A), size: 26),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      Text(item['location'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                      const SizedBox(height: 4),
                                      Text(item['capacity'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: isAvailable
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BookingTimelineScreen(
                                                facility: item,
                                                onConfirmBooking: widget.onBook,
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isAvailable ? const Color(0xFF166534) : const Color(0xFFFEE2E2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      isAvailable ? 'PINJAM' : 'TERPAKAI',
                                      style: TextStyle(
                                        color: isAvailable ? Colors.white : const Color(0xFF991B1B),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ✨ DYNAMIC ISLAND / FLOATING PILL TETAP MENGAPUNG DI ATAS
          Positioned(
            top: 14,
            left: 0,
            right: 0,
            child: Center(
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 800),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Opacity(
                      opacity: value,
                      child: child,
                    ),
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✨ Parallax & Dynamic Island Aktif: Sistem Peminjaman Ruangan & Aset UNESA.'),
                        backgroundColor: Color(0xFF1E3A8A),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(180),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withAlpha(40), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(60),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Colors.greenAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'AI Asisten & Server Online',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.auto_awesome_rounded,
                          color: Colors.amber,
                          size: 13,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatCard(String count, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withAlpha(40)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(count, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFFE2E8F0))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AIChatbotModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onBook;

  const AIChatbotModal({super.key, required this.onBook});

  @override
  State<AIChatbotModal> createState() => _AIChatbotModalState();
}

class _AIChatbotModalState extends State<AIChatbotModal> {
  final TextEditingController _msgController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'ai',
      'text': 'Halo Akhdan! 👋 Saya AI Asisten Kampus UNESA. Ketuk salah satu prompt di bawah atau ketik fasilitas yang kamu butuhkan:',
      'facility': null,
    },
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text, 'facility': null});
    });

    _msgController.clear();

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;

      Map<String, dynamic>? recommendedFacility;
      String replyText = 'Berikut adalah fasilitas rekomendasi yang tersedia sesuai permintaan Anda:';

      final query = text.toLowerCase();
      if (query.contains('proyektor') || query.contains('alat') || query.contains('sewa')) {
        recommendedFacility = {
          'title': 'Proyektor Epson LCD Full HD',
          'location': 'Ruang Laboran Lt. 1',
          'capacity': 'Unit #01 • Status Ready',
          'icon': Icons.videocam_rounded,
          'isAvailable': true,
        };
        replyText = 'Saya menemukan Proyektor Epson HD yang siap dipinjam sekarang:';
      } else if (query.contains('lab') || query.contains('komputer')) {
        recommendedFacility = {
          'title': 'Lab Komputer Dasar 2',
          'location': 'Lantai 2 - Gedung Laboratorium',
          'capacity': '35 Kursi • Status Ready',
          'icon': Icons.desktop_windows_rounded,
          'isAvailable': true,
        };
        replyText = 'Berikut Lab Komputer yang sedang kosong dan dapat langsung dipinjam:';
      } else if (query.contains('seminar') || query.contains('ruang') || query.contains('rapat')) {
        recommendedFacility = {
          'title': 'Ruang Rapat Senat Kampus',
          'location': 'Lantai 1 - Rektorat',
          'capacity': '25 Orang • Status Ready',
          'icon': Icons.groups_rounded,
          'isAvailable': true,
        };
        replyText = 'Rekomendasi ruangan rapat/seminar terbaik untuk Anda:';
      } else {
        recommendedFacility = {
          'title': 'Co-Working Space UKM',
          'location': 'Gedung Student Center Lt. 1',
          'capacity': '50 Orang • Status Ready',
          'icon': Icons.door_sliding_rounded,
          'isAvailable': true,
        };
      }

      setState(() {
        _messages.add({
          'sender': 'ai',
          'text': replyText,
          'facility': recommendedFacility,
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A8A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.smart_toy_rounded, color: Color(0xFF1E3A8A)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AI Asisten Kampus UNESA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Online • Pengarah Peminjaman Langsung', style: TextStyle(color: Color(0xFF93C5FD), fontSize: 11)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                final facility = msg['facility'];

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF1E3A8A) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg['text'],
                          style: TextStyle(
                            color: isUser ? Colors.white : const Color(0xFF0F172A),
                            fontSize: 13,
                          ),
                        ),
                        if (facility != null) ...[
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFBFDBFE)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(facility['icon'], color: const Color(0xFF1E3A8A), size: 22),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        facility['title'],
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(facility['location'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                const SizedBox(height: 2),
                                Text(facility['capacity'], style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  height: 36,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF166534),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookingTimelineScreen(
                                            facility: facility,
                                            onConfirmBooking: widget.onBook,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                                    label: const Text('PINJAM SEKARANG', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildPromptChip('Cari Lab Komputer'),
                _buildPromptChip('Sewa Proyektor HD'),
                _buildPromptChip('Cari Ruang Seminar'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              top: 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: 'Tanyakan sesuatu ke AI...',
                      filled: true,
                      fillColor: const Color(0xFFF1F5F9),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF1E3A8A),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                    onPressed: () => _sendMessage(_msgController.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromptChip(String label) {
    return GestureDetector(
      onTap: () => _sendMessage(label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFBFDBFE)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF1E3A8A), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}