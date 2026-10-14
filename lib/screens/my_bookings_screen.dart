import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyBookingsPage extends StatefulWidget {
  final List<Map<String, dynamic>> bookingList;
  final Function(int points, String title, String desc) onAddPoints;

  const MyBookingsPage({
    super.key,
    required this.bookingList,
    required this.onAddPoints,
  });

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  String _filterStatus = 'All';
  final ImagePicker _picker = ImagePicker();

  // DIALOG TIKET DIGITAL / E-PASS QR CODE
  void _showEPassDialog(Map<String, dynamic> booking) {
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
              // Indicator Bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              // CARD BOARDING PASS DIGITAL
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1E3A8A).withAlpha(50),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header E-Pass
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.confirmation_number_rounded, color: Colors.amber, size: 22),
                              SizedBox(width: 8),
                              Text(
                                'UNESA DIGITAL PASS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'VERIFIED',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Dashed Line Divider
                    Row(
                      children: List.generate(
                        30,
                        (index) => Expanded(
                          child: Container(
                            color: index % 2 == 0 ? Colors.transparent : Colors.white24,
                            height: 2,
                          ),
                        ),
                      ),
                    ),

                    // Body E-Pass & QR Code
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            booking['title'] ?? 'Fasilitas Kampus',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            booking['location'] ?? 'Lokasi Kampus',
                            style: const TextStyle(fontSize: 12, color: Color(0xFF93C5FD)),
                          ),
                          const SizedBox(height: 20),

                          // QR CODE DUMMY ARTWORK
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.qr_code_2_rounded,
                                  size: 160,
                                  color: Color(0xFF0F172A),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'ID: UNESA-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Detail Peminjam
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('TANGGAL', style: TextStyle(fontSize: 10, color: Color(0xFF93C5FD))),
                                  const SizedBox(height: 2),
                                  Text(
                                    booking['date'] ?? 'Hari Ini',
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('SLOT WAKTU', style: TextStyle(fontSize: 10, color: Color(0xFF93C5FD))),
                                  const SizedBox(height: 2),
                                  Text(
                                    booking['timeSlot'] ?? '08:00 - 10:00',
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tunjukkan QR Code ini kepada petugas/laboran saat berada di lokasi',
                style: TextStyle(fontSize: 11, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showReviewDialog(int index) {
    double selectedRating = 5;
    final TextEditingController reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Row(
                children: [
                  Icon(Icons.rate_review_rounded, color: Color(0xFF1E3A8A)),
                  SizedBox(width: 8),
                  Text('Beri Ulasan Fasilitas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Berikan penilaian pengalaman penggunaan:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (starIndex) {
                      return IconButton(
                        icon: Icon(
                          starIndex < selectedRating ? Icons.star_rounded : Icons.star_outline_rounded,
                          color: Colors.amber,
                          size: 32,
                        ),
                        onPressed: () {
                          setDialogState(() {
                            selectedRating = starIndex + 1.0;
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: reviewController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Tulis kesan, kebersihan, atau kelengkapan alat/ruang...',
                      hintStyle: const TextStyle(fontSize: 12),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('BATAL', style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    final bool firstTime = widget.bookingList[index]['review'] == null;
                    setState(() {
                      widget.bookingList[index]['review'] = reviewController.text;
                      widget.bookingList[index]['rating'] = selectedRating;
                    });

                    if (firstTime) {
                      widget.onAddPoints(
                        5,
                        'Ulasan Fasilitas',
                        widget.bookingList[index]['title'] ?? 'Fasilitas Kampus',
                      );
                    }

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ulasan disimpan! +5 Poin Trust Score bertambah.'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text('KIRIM ULASAN', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showUploadProofSheet(int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Unggah Foto Bukti Pengembalian',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 4),
              const Text(
                'Ambil foto kondisi akhir ruangan/barang sebelum diserahkan ke laboran',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () async {
                      Navigator.pop(sheetContext);
                      final XFile? image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 70);
                      if (image != null) {
                        final bool firstTime = widget.bookingList[index]['proofImage'] == null;
                        setState(() {
                          widget.bookingList[index]['proofImage'] = image.path;
                        });
                        if (firstTime) {
                          widget.onAddPoints(
                            10,
                            'Bukti Foto Pengembalian',
                            widget.bookingList[index]['title'] ?? 'Fasilitas Kampus',
                          );
                        }
                      }
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xFF1E3A8A),
                          child: Icon(Icons.camera_alt_rounded, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text('Kamera', style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () async {
                      Navigator.pop(sheetContext);
                      final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
                      if (image != null) {
                        final bool firstTime = widget.bookingList[index]['proofImage'] == null;
                        setState(() {
                          widget.bookingList[index]['proofImage'] = image.path;
                        });
                        if (firstTime) {
                          widget.onAddPoints(
                            10,
                            'Bukti Foto Pengembalian',
                            widget.bookingList[index]['title'] ?? 'Fasilitas Kampus',
                          );
                        }
                      }
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xFF1E3A8A),
                          child: Icon(Icons.photo_library_rounded, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text('Galeri Foto', style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredBookings = widget.bookingList.where((item) {
      if (_filterStatus == 'All') return true;
      return item['status'].toString().toLowerCase() == _filterStatus.toLowerCase();
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 52, bottom: 28, left: 20, right: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF1E3A8A), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.assignment_turned_in_rounded, color: Colors.white, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Riwayat Peminjaman Saya',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Kelola tiket QR, beri ulasan, dan unggah foto bukti pengembalian',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Color(0xFF93C5FD)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: ['All', 'Approved', 'Pending', 'Returned'].map((status) {
                      final isSelected = _filterStatus == status;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _filterStatus = status),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade300,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                status,
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
                  const SizedBox(height: 20),
                  filteredBookings.isEmpty
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Column(
                            children: [
                              Icon(Icons.inbox_rounded, size: 48, color: Colors.grey),
                              SizedBox(height: 12),
                              Text(
                                'Belum ada riwayat peminjaman',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredBookings.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final booking = filteredBookings[index];
                            final String? proofPath = booking['proofImage'];
                            final String? review = booking['review'];
                            final double? rating = booking['rating'];

                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade200),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(5),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        booking['date'] ?? 'Hari Ini',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2563EB),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withAlpha(20),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          booking['status'] ?? 'Approved',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    booking['title'] ?? 'Fasilitas Kampus',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    booking['location'] ?? '-',
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time_rounded, size: 14, color: Colors.grey),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Slot: ${booking['timeSlot'] ?? '-'}',
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.notes_rounded, size: 14, color: Colors.grey),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          'Keperluan: ${booking['purpose'] ?? '-'}',
                                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // TOMBOL LIHAT E-PASS / TIKET DIGITAL QR
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 38,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF0F172A),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () => _showEPassDialog(booking),
                                      icon: const Icon(Icons.qr_code_rounded, size: 18, color: Colors.amber),
                                      label: const Text(
                                        'TAMPILKAN E-PASS / QR CODE TIKET',
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                                      ),
                                    ),
                                  ),

                                  if (proofPath != null) ...[
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: kIsWeb
                                                ? Image.network(proofPath, width: 44, height: 44, fit: BoxFit.cover)
                                                : Image.file(File(proofPath), width: 44, height: 44, fit: BoxFit.cover),
                                          ),
                                          const SizedBox(width: 10),
                                          const Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Bukti Pengembalian Ada', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                                Text('Foto kondisi akhir (+10 Poin)', style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          const Icon(Icons.check_circle, color: Colors.green, size: 20),
                                        ],
                                      ),
                                    ),
                                  ],
                                  if (review != null) ...[
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFFBEB),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: const Color(0xFFFDE68A)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                children: List.generate(
                                                  (rating ?? 5).toInt(),
                                                  (i) => const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                '${rating ?? 5.0}',
                                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.amber),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '"$review"',
                                            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF78350F)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  const Divider(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton.icon(
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: const Color(0xFF1E3A8A),
                                            side: const BorderSide(color: Color(0xFFBFDBFE)),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            padding: const EdgeInsets.symmetric(vertical: 8),
                                          ),
                                          onPressed: () => _showUploadProofSheet(index),
                                          icon: const Icon(Icons.add_a_photo_outlined, size: 16),
                                          label: Text(
                                            proofPath == null ? 'Foto Bukti (+10)' : 'Ubah Foto',
                                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF1E3A8A),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            padding: const EdgeInsets.symmetric(vertical: 8),
                                            elevation: 0,
                                          ),
                                          onPressed: () => _showReviewDialog(index),
                                          icon: const Icon(Icons.rate_review_outlined, size: 16),
                                          label: Text(
                                            review == null ? 'Ulasan (+5)' : 'Edit Ulasan',
                                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
}