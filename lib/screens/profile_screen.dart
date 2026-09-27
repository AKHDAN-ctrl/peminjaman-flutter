import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'auth_screen.dart';

class ProfilePage extends StatefulWidget {
  final UserRole userRole;
  final String userName;
  final String userId;
  final String userEmail;
  final String extraInfo;

  const ProfilePage({
    super.key,
    required this.userRole,
    required this.userName,
    required this.userId,
    required this.userEmail,
    required this.extraInfo,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String currentName;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    currentName = widget.userName;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto profil berhasil diubah!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengambil gambar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showEditNameDialog() {
    final nameController = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Nama Lengkap'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap Baru',
              prefixIcon: Icon(Icons.edit_outlined),
            ),
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
                if (nameController.text.trim().isNotEmpty) {
                  setState(() {
                    currentName = nameController.text.trim();
                  });
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nama berhasil diperbarui!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showImageSourcePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Ganti Foto Profil',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(sheetContext);
                        _pickImage(ImageSource.gallery);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Color(0xFF1E3A8A),
                            child: Icon(Icons.photo_library_rounded, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text('Galeri Foto'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(sheetContext);
                        _pickImage(ImageSource.camera);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Color(0xFF1E3A8A),
                            child: Icon(Icons.camera_alt_rounded, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text('Kamera'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // METHOD PEMANGGIL FOTO ASSET PROFILE.PNG
  Widget _buildProfileImage() {
    if (_imageFile != null) {
      if (kIsWeb) {
        return CircleAvatar(
          radius: 52,
          backgroundImage: NetworkImage(_imageFile!.path),
        );
      } else {
        return CircleAvatar(
          radius: 52,
          backgroundImage: FileImage(File(_imageFile!.path)),
        );
      }
    }

    // Default mengambil foto dari folder assets/profile.png
    return const CircleAvatar(
      radius: 52,
      backgroundImage: AssetImage('assets/profile.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final roleText = widget.userRole == UserRole.mahasiswa ? 'Mahasiswa' : 'Staf Pengelola';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Foto Profil dengan tombol edit kamera
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                _buildProfileImage(),
                InkWell(
                  onTap: _showImageSourcePicker,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentName,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20, color: Color(0xFF1E3A8A)),
                  onPressed: _showEditNameDialog,
                ),
              ],
            ),
            Text(
              roleText,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.badge_outlined, color: Color(0xFF1E3A8A)),
                      title: Text(widget.userRole == UserRole.mahasiswa ? 'NIM' : 'NIP'),
                      subtitle: Text(widget.userId),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.email_outlined, color: Color(0xFF1E3A8A)),
                      title: const Text('Email Kampus'),
                      subtitle: Text(widget.userEmail),
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(
                        widget.userRole == UserRole.mahasiswa
                            ? Icons.groups_outlined
                            : Icons.business_outlined,
                        color: const Color(0xFF1E3A8A),
                      ),
                      title: Text(widget.userRole == UserRole.mahasiswa
                          ? 'Organisasi / UKM'
                          : 'Unit Pengelola'),
                      subtitle: Text(widget.extraInfo),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.logout_rounded),
                label: const Text('KELUAR AKUN', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
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