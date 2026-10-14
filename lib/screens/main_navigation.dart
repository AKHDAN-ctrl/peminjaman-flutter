import 'package:flutter/material.dart';
import 'catalog_screen.dart';
import 'my_bookings_screen.dart';
import 'profile_screen.dart';
import '../main.dart';

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
  int _currentIndex = 0;
  int _trustScore = 90; // Trust score awal

  final List<Map<String, dynamic>> _myBookings = [
    {
      'title': 'Lab Komputer Lanjut 1',
      'location': 'Lantai 2 - Gedung Laboratorium',
      'timeSlot': '08:00 - 10:00',
      'date': '15/10/2026',
      'purpose': 'Praktikum Jaringan Komputer',
      'status': 'Approved',
    },
  ];

  final List<Map<String, dynamic>> _scoreHistory = [
    {
      'title': 'Pengembalian Tepat Waktu',
      'desc': 'Proyektor Epson LCD Full HD',
      'points': '+5 Poin',
      'isPositive': true,
      'date': '12 Okt 2026',
    },
  ];

  void _addNewBooking(Map<String, dynamic> newBooking) {
    setState(() {
      _myBookings.insert(0, newBooking);
    });
  }

  // FUNGSI UNTUK MENAMBAH POIN TRUST SCORE OTOMATIS
  void _addTrustPoints(int points, String title, String desc) {
    setState(() {
      _trustScore = (_trustScore + points).clamp(0, 100);
      _scoreHistory.insert(0, {
        'title': title,
        'desc': desc,
        'points': '+$points Poin',
        'isPositive': true,
        'date': 'Hari Ini',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CatalogPage(
        onBook: _addNewBooking,
        userId: widget.userId,
        userEmail: widget.userEmail,
      ),
      MyBookingsPage(
        bookingList: _myBookings,
        onAddPoints: _addTrustPoints, // Teruskan fungsi penambahan poin
      ),
      ProfilePage(
        userRole: widget.userRole.name,
        userName: widget.userName,
        userId: widget.userId,
        userEmail: widget.userEmail,
        extraInfo: widget.extraInfo,
        trustScore: _trustScore, // Teruskan trust score dinamis
        scoreHistory: _scoreHistory, // Teruskan riwayat poin dinamis
      ),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF1E3A8A),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Katalog',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded),
              label: 'Pinjaman',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}