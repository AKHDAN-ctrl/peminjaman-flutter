import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/my_bookings_screen.dart';
import 'screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final UserRole userRole;
  final String userName;
  final String userId;
  final String userEmail;
  final String extraInfo;

  const MainNavigationScreen({
    super.key,
    required this.userRole,
    required this.userName,
    required this.userId,
    required this.userEmail,
    required this.extraInfo,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> bookingList = [
    {
      'id': 'BK-9982',
      'title': 'Auditorium Utama Gedung A',
      'date': '24 Sep 2026',
      'purpose': 'Gladi Bersih Seminar Nasional',
      'status': 'Menunggu Approval',
      'type': 'Ruangan',
      'icon': Icons.account_balance_rounded,
    },
    {
      'id': 'BK-9841',
      'title': 'Proyektor Epson HD + HDMI',
      'date': '20 Sep 2026',
      'purpose': 'Presentasi Tugas Akhir',
      'status': 'Disetujui',
      'type': 'Barang',
      'icon': Icons.videocam_rounded,
    },
  ];

  void _addBooking(Map<String, dynamic> newBooking) {
    setState(() {
      bookingList.insert(0, newBooking);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CatalogDashboardPage(
        userRole: widget.userRole,
        userName: widget.userName,
        onAddBooking: _addBooking,
      ),
      MyBookingsPage(bookingList: bookingList),
      ProfilePage(
        userRole: widget.userRole,
        userName: widget.userName,
        userId: widget.userId,
        userEmail: widget.userEmail,
        extraInfo: widget.extraInfo,
      ),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1E3A8A),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Pinjaman',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}