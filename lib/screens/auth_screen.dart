import 'package:flutter/material.dart';
import '../main_navigation.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum UserRole { mahasiswa, staf }

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  UserRole selectedRole = UserRole.mahasiswa;
  bool isObscurePassword = true;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ukmController = TextEditingController();

  String selectedUnit = 'Pengelola Ruangan';
  final List<String> unitList = [
    'Pengelola Ruangan',
    'Pengelola Inventaris Barang',
    'Laboran',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    _ukmController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final roleName = selectedRole == UserRole.mahasiswa ? 'Mahasiswa' : 'Staf Pengelola';
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Berhasil sebagai $roleName!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigationScreen(
            userRole: selectedRole,
            userName: _nameController.text.isEmpty ? 'Akhdan Farrel Bernadine' : _nameController.text,
            userId: _idController.text.isEmpty ? '22010199' : _idController.text,
            userEmail: _emailController.text.isEmpty ? 'akhdan@kampus.ac.id' : _emailController.text,
            extraInfo: selectedRole == UserRole.mahasiswa 
                ? (_ukmController.text.isEmpty ? 'UKM Robotik' : _ukmController.text)
                : selectedUnit,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.meeting_room_rounded,
                    size: 64,
                    color: Color(0xFF1E3A8A),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Campus Space & Asset',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const Text(
                    'Sistem Peminjaman Ruangan & Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),

                  SegmentedButton<UserRole>(
                    segments: const [
                      ButtonSegment<UserRole>(
                        value: UserRole.mahasiswa,
                        label: Text('Mahasiswa'),
                        icon: Icon(Icons.school_outlined),
                      ),
                      ButtonSegment<UserRole>(
                        value: UserRole.staf,
                        label: Text('Staf Pengelola'),
                        icon: Icon(Icons.admin_panel_settings_outlined),
                      ),
                    ],
                    selected: {selectedRole},
                    onSelectionChanged: (Set<UserRole> newSelection) {
                      setState(() {
                        selectedRole = newSelection.first;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          if (!isLogin) ...[
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Nama Lengkap',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama lengkap tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                          ],

                          TextFormField(
                            controller: _idController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: selectedRole == UserRole.mahasiswa ? 'NIM' : 'NIP / ID Staf',
                              prefixIcon: const Icon(Icons.badge_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '${selectedRole == UserRole.mahasiswa ? "NIM" : "NIP"} tidak boleh kosong';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Harus berupa angka';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          if (!isLogin) ...[
                            if (selectedRole == UserRole.mahasiswa) ...[
                              TextFormField(
                                controller: _ukmController,
                                decoration: const InputDecoration(
                                  labelText: 'Nama UKM / Organisasi (Opsional)',
                                  prefixIcon: Icon(Icons.groups_outlined),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],

                            if (selectedRole == UserRole.staf) ...[
                              DropdownButtonFormField<String>(
                                initialValue: selectedUnit,
                                decoration: const InputDecoration(
                                  labelText: 'Unit Pengelola',
                                  prefixIcon: Icon(Icons.business_outlined),
                                ),
                                items: unitList.map((String unit) {
                                  return DropdownMenuItem<String>(
                                    value: unit,
                                    child: Text(unit),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedUnit = value!;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                            ],
                          ],

                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email Kampus',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }
                              if (!value.contains('@')) {
                                return 'Format email tidak valid';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: isObscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscurePassword ? Icons.visibility_off : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isObscurePassword = !isObscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              if (value.length < 8) {
                                return 'Password minimal 8 karakter';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E3A8A),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                isLogin ? 'MASUK' : 'DAFTAR SEKARANG',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLogin ? 'Belum punya akun?' : 'Sudah punya akun?',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                            _formKey.currentState?.reset();
                          });
                        },
                        child: Text(
                          isLogin ? 'Daftar' : 'Login',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}