import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Import splash screen

void main() {
  runApp(const CampusSpaceApp());
}

enum UserRole { mahasiswa, dosen }

class CampusSpaceApp extends StatelessWidget {
  const CampusSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Space & Asset (sigma_unesa)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3A8A)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(), // Mulai dari SplashScreen beranimasi
    );
  }
}