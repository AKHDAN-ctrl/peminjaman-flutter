import 'package:flutter/material.dart';

class BookingTimelineScreen extends StatefulWidget {
  final Map<String, dynamic> facility;
  final Function(Map<String, dynamic>) onConfirmBooking;

  const BookingTimelineScreen({
    super.key,
    required this.facility,
    required this.onConfirmBooking,
  });

  @override
  State<BookingTimelineScreen> createState() => _BookingTimelineScreenState();
}

class _BookingTimelineScreenState extends State<BookingTimelineScreen> {
  DateTime _selectedDate = DateTime.now();
  int? _selectedSlotIndex;
  final TextEditingController _purposeController = TextEditingController();

  final List<Map<String, dynamic>> _timeSlots = [
    {
      'time': '08:00 - 10:00',
      'isAvailable': true,
      'bookedBy': null,
    },
    {
      'time': '10:00 - 12:00',
      'isAvailable': false,
      'bookedBy': 'HMP Teknik Informatika (Kuliah Tamu)',
    },
    {
      'time': '12:00 - 13:00',
      'isAvailable': false,
      'bookedBy': 'Istirahat / Pemeliharaan Ruang',
    },
    {
      'time': '13:00 - 15:00',
      'isAvailable': true,
      'bookedBy': null,
    },
    {
      'time': '15:00 - 17:00',
      'isAvailable': true,
      'bookedBy': null,
    },
    {
      'time': '18:30 - 20:30',
      'isAvailable': false,
      'bookedBy': 'UKM Robotik UNESA (Rapat Rutin)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Timeline Ketersediaan', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF1E3A8A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(30),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      widget.facility['icon'] ?? Icons.meeting_room_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.facility['title'] ?? 'Fasilitas Kampus',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.facility['location'] ?? 'Lokasi Kampus',
                          style: const TextStyle(fontSize: 13, color: Color(0xFF93C5FD)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pilih Tanggal Peminjaman',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        final date = DateTime.now().add(Duration(days: index));
                        final isSelected = _selectedDate.day == date.day &&
                            _selectedDate.month == date.month;

                        final daysName = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Ming'];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDate = date;
                              _selectedSlotIndex = null;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 64,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade300,
                              ),
                              boxShadow: [
                                if (isSelected)
                                  const BoxShadow(
                                    color: Color(0x331E3A8A),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  daysName[date.weekday - 1],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected ? const Color(0xFF93C5FD) : Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : const Color(0xFF0F172A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Jadwal & Slot Waktu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        '${_timeSlots.where((s) => s['isAvailable']).length} Slot Kosong',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF22C55E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _timeSlots.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final slot = _timeSlots[index];
                      final bool isAvailable = slot['isAvailable'];
                      final bool isChosen = _selectedSlotIndex == index;

                      return GestureDetector(
                        onTap: isAvailable
                            ? () {
                                setState(() {
                                  _selectedSlotIndex = index;
                                });
                              }
                            : null,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isChosen
                                ? const Color(0xFFEFF6FF)
                                : isAvailable
                                    ? Colors.white
                                    : const Color(0xFFFEE2E2).withAlpha(100),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isChosen
                                  ? const Color(0xFF2563EB)
                                  : isAvailable
                                      ? Colors.grey.shade300
                                      : const Color(0xFFFCA5A5),
                              width: isChosen ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time_filled_rounded,
                                color: isChosen
                                    ? const Color(0xFF2563EB)
                                    : isAvailable
                                        ? const Color(0xFF1E3A8A)
                                        : Colors.red.shade400,
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      slot['time'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: isAvailable
                                            ? const Color(0xFF0F172A)
                                            : Colors.red.shade900,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      isAvailable
                                          ? 'Status: Tersedia untuk dipinjam'
                                          : 'Dipinjam: ${slot['bookedBy']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isAvailable ? Colors.grey : Colors.red.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isAvailable)
                                Icon(
                                  isChosen
                                      ? Icons.check_circle_rounded
                                      : Icons.radio_button_unchecked_rounded,
                                  color: isChosen ? const Color(0xFF2563EB) : Colors.grey,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  if (_selectedSlotIndex != null) ...[
                    const Text(
                      'Keperluan Peminjaman',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _purposeController,
                      decoration: InputDecoration(
                        hintText: 'Contoh: Latihan UKM Robotik / Praktikum Matkul',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          if (_purposeController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Mohon isi keperluan peminjaman'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          final selectedSlot = _timeSlots[_selectedSlotIndex!];
                          final bookingData = {
                            'title': widget.facility['title'],
                            'location': widget.facility['location'],
                            'timeSlot': selectedSlot['time'],
                            'date': '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            'purpose': _purposeController.text.trim(),
                            'status': 'Approved',
                          };

                          widget.onConfirmBooking(bookingData);
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Berhasil meminjam ${widget.facility['title']} untuk slot ${selectedSlot['time']}'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.check_circle_outline_rounded),
                        label: const Text(
                          'KONFIRMASI PEMINJAMAN SLOT',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}