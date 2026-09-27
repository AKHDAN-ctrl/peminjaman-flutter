import 'package:flutter/material.dart';
import 'auth_screen.dart';

class CatalogDashboardPage extends StatefulWidget {
  final UserRole userRole;
  final String userName;
  final Function(Map<String, dynamic>) onAddBooking;

  const CatalogDashboardPage({
    super.key,
    required this.userRole,
    required this.userName,
    required this.onAddBooking,
  });

  @override
  State<CatalogDashboardPage> createState() => _CatalogDashboardPageState();
}

class _CatalogDashboardPageState extends State<CatalogDashboardPage> {
  int _selectedAssetType = 0; // 0 = Ruangan, 1 = Barang

  // DAFTAR RUANGAN LEBIH BANYAK & Bervariasi
  final List<Map<String, dynamic>> roomList = [
    {
      'title': 'Auditorium Utama Gedung A',
      'location': 'Lantai 3 - Gedung Utama',
      'capacity': '300 Orang',
      'isAvailable': true,
      'icon': Icons.account_balance_rounded,
      'type': 'Ruangan',
    },
    {
      'title': 'Lab Komputer Lanjut 1',
      'location': 'Lantai 2 - Gedung Laboratorium',
      'capacity': '40 Kursi',
      'isAvailable': false,
      'icon': Icons.computer_rounded,
      'type': 'Ruangan',
    },
    {
      'title': 'Lab Komputer Dasar 2',
      'location': 'Lantai 2 - Gedung Laboratorium',
      'capacity': '35 Kursi',
      'isAvailable': true,
      'icon': Icons.desktop_windows_rounded,
      'type': 'Ruangan',
    },
    {
      'title': 'Ruang Rapat Senat Kampus',
      'location': 'Lantai 1 - Rektorat',
      'capacity': '25 Orang',
      'isAvailable': true,
      'icon': Icons.groups_rounded,
      'type': 'Ruangan',
    },
    {
      'title': 'Co-Working Space & Studio UKM',
      'location': 'Gedung Student Center Lt. 1',
      'capacity': '50 Orang',
      'isAvailable': true,
      'icon': Icons.meeting_room_rounded,
      'type': 'Ruangan',
    },
    {
      'title': 'Ruang Kuliah Teori B-102',
      'location': 'Lantai 1 - Gedung Perkuliahan B',
      'capacity': '60 Kursi',
      'isAvailable': true,
      'icon': Icons.class_outlined,
      'type': 'Ruangan',
    },
    {
      'title': 'Ruang Kuliah Teori B-204',
      'location': 'Lantai 2 - Gedung Perkuliahan B',
      'capacity': '60 Kursi',
      'isAvailable': false,
      'icon': Icons.class_outlined,
      'type': 'Ruangan',
    },
    {
      'title': 'Aula Serbaguna Kampus',
      'location': 'Gedung Olahraga & Seni',
      'capacity': '500 Orang',
      'isAvailable': true,
      'icon': Icons.stadium_rounded,
      'type': 'Ruangan',
    },
    {
      'title': 'Ruang Diskusi Perpustakaan A',
      'location': 'Lantai 2 - Perpustakaan Pusat',
      'capacity': '10 Orang',
      'isAvailable': true,
      'icon': Icons.local_library_rounded,
      'type': 'Ruangan',
    },
    {
      'title': 'Studio Radio & Podcast UKM',
      'location': 'Gedung Student Center Lt. 2',
      'capacity': '8 Orang',
      'isAvailable': true,
      'icon': Icons.mic_external_on_rounded,
      'type': 'Ruangan',
    },
     {
      'title': 'A10.01.01',
      'location': 'Gedung A10 Lt. 1',
      'capacity': '30 Orang',
      'isAvailable': true,
      'icon': Icons.class_outlined,
      'type': 'Ruangan',
    },
    {
      'title': 'A10.01.02',
      'location': 'Gedung A10 Lt. 1',
      'capacity': '30 Orang',
      'isAvailable': true,
      'icon': Icons.class_outlined,
      'type': 'Ruangan',
    },
    {
      'title': 'A10.01.19',
      'location': 'Gedung A10 Lt. 1',
      'capacity': '30 Orang',
      'isAvailable': true,
      'icon': Icons.class_outlined,
      'type': 'Ruangan',
    },
    {
      'title': 'A10.01.03',
      'location': 'Gedung A10 Lt. 1',
      'capacity': '30 Orang',
      'isAvailable': true,
      'icon': Icons.class_outlined,
      'type': 'Ruangan',
    },
  ];

  final List<Map<String, dynamic>> itemList = [
    {
      'title': 'Proyektor Epson HD + HDMI',
      'location': 'Ruang Stok Inventaris B',
      'capacity': 'Tersedia 5 Unit',
      'isAvailable': true,
      'icon': Icons.videocam_rounded,
      'type': 'Barang',
    },
    {
      'title': 'Sound System Portable + Mic',
      'location': 'Ruang Stok Inventaris A',
      'capacity': 'Tersedia 2 Set',
      'isAvailable': true,
      'icon': Icons.speaker_group_rounded,
      'type': 'Barang',
    },
    {
      'title': 'Kabel Rol Industrial 15m',
      'location': 'Ruang Stok Inventaris A',
      'capacity': 'Dipakai Semua',
      'isAvailable': false,
      'icon': Icons.cable_rounded,
      'type': 'Barang',
    },
    {
      'title': 'Papan Tulis Portable Dual Side',
      'location': 'Gedung C - Lantai 1',
      'capacity': 'Tersedia 3 Unit',
      'isAvailable': true,
      'icon': Icons.draw_rounded,
      'type': 'Barang',
    },
  ];

  void _showBookingDialog(Map<String, dynamic> item) {
    final purposeController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Pinjam ${item['title']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.calendar_today_rounded),
                title: Text(
                  'Tanggal: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                ),
                trailing: const Icon(Icons.arrow_drop_down),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: dialogContext,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2027),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: purposeController,
                decoration: const InputDecoration(
                  labelText: 'Tujuan Peminjaman',
                  hintText: 'Contoh: Rapat UKM / Kuliah',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (purposeController.text.isNotEmpty) {
                  widget.onAddBooking({
                    'id': 'BK-${(1000 + (item['title'].toString().length * 123))}',
                    'title': item['title'],
                    'date': '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    'purpose': purposeController.text,
                    'status': 'Menunggu Approval',
                    'type': item['type'],
                    'icon': item['icon'],
                  });
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pengajuan Peminjaman Berhasil Dikirim!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Kirim Pengajuan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentList = _selectedAssetType == 0 ? roomList : itemList;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, ${widget.userName}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.userRole == UserRole.mahasiswa ? 'Mahasiswa' : 'Staf Pengelola',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const CircleAvatar(
                 backgroundColor: Color(0xFF1E3A8A),
                 backgroundImage: AssetImage('assets/profile.png'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: _selectedAssetType == 0 ? 'Cari ruangan...' : 'Cari barang...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Ruangan Kampus')),
                    selected: _selectedAssetType == 0,
                    selectedColor: const Color(0xFF1E3A8A),
                    labelStyle: TextStyle(
                      color: _selectedAssetType == 0 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedAssetType = 0;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Barang / Fasilitas')),
                    selected: _selectedAssetType == 1,
                    selectedColor: const Color(0xFF1E3A8A),
                    labelStyle: TextStyle(
                      color: _selectedAssetType == 1 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedAssetType = 1;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // MENGGUNAKAN LISTVIEW.BUILDER UNTUK MENAMPILKAN BANYAK RUANGAN
            Expanded(
              child: ListView.builder(
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  final item = currentList[index];
                  final bool available = item['isAvailable'];

                  return Card(
                    elevation: 1.5,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: available ? () => _showBookingDialog(item) : null,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E3A8A).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                item['icon'],
                                color: const Color(0xFF1E3A8A),
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['location'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.people_alt_outlined, size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        item['capacity'],
                                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: available ? Colors.green[50] : Colors.red[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                available ? 'Pinjam' : 'Terpakai',
                                style: TextStyle(
                                  color: available ? Colors.green[700] : Colors.red[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}