import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Peminjaman Disetujui! 🎉',
      'desc': 'Peminjaman Lab Komputer Dasar 2 untuk tanggal hari ini telah disetujui oleh Laboran.',
      'time': '10 Menit yang lalu',
      'isRead': false,
      'type': 'approved',
    },
    {
      'title': 'Pengingat Pengembalian Aset ⏰',
      'desc': 'Waktu peminjaman Proyektor Epson HD tersisa 30 menit lagi. Harap segera dikembalikan.',
      'time': '1 Jam yang lalu',
      'isRead': false,
      'type': 'reminder',
    },
    {
      'title': '+10 Poin Trust Score Bertambah! ⭐',
      'desc': 'Terima kasih telah mengunggah foto bukti pengembalian tepat waktu.',
      'time': 'Kemarin, 16:30 WIB',
      'isRead': true,
      'type': 'reward',
    },
    {
      'title': 'Konfirmasi Email Dikirim 📧',
      'desc': 'E-Pass QR Code dan rincian peminjaman telah dikirimkan ke email mhs@unesa.ac.id.',
      'time': '2 Hari yang lalu',
      'isRead': true,
      'type': 'email',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('Pusat Notifikasi', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all_rounded),
            tooltip: 'Tandai Semua Dibaca',
            onPressed: () {
              setState(() {
                for (var n in _notifications) {
                  n['isRead'] = true;
                }
              });
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _notifications[index];
          final bool isRead = item['isRead'];

          IconData icon;
          Color color;
          switch (item['type']) {
            case 'approved':
              icon = Icons.check_circle_rounded;
              color = Colors.green;
              break;
            case 'reminder':
              icon = Icons.alarm_rounded;
              color = Colors.orange;
              break;
            case 'reward':
              icon = Icons.stars_rounded;
              color = Colors.amber;
              break;
            default:
              icon = Icons.mark_email_read_rounded;
              color = const Color(0xFF1E3A8A);
          }

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isRead ? Colors.white : const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isRead ? Colors.grey.shade200 : const Color(0xFFBFDBFE),
                width: isRead ? 1 : 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: color.withAlpha(25),
                  radius: 22,
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item['title'],
                              style: TextStyle(
                                fontWeight: isRead ? FontWeight.bold : FontWeight.w900,
                                fontSize: 14,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          if (!isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF2563EB),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['desc'],
                        style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['time'],
                        style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}