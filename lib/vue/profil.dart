import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forumfinal/vue/composant/bottomnavbar.dart';
import 'package:forumfinal/widgets/myscaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final storage = FlutterSecureStorage(); // Initialize SecureStorage

  String name = '';
  String surname = '';
  String email = '';
  String dateInscription = '';

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data when the screen is initialized
  }

  // Load user data from SecureStorage
  Future<void> _loadUserData() async {
    final loadedName = await storage.read(key: 'name');
    final loadedSurname = await storage.read(key: 'surname');
    final loadedEmail = await storage.read(key: 'email');
    final loadedDateInscription = await storage.read(key: 'dateInscription');

    setState(() {
      name = loadedName ?? 'Not Available';
      surname = loadedSurname ?? 'Not Available';
      email = loadedEmail ?? 'Not Available';
      dateInscription = loadedDateInscription ?? 'Not Available';
    });
  }

  // Save user data to SecureStorage (for demonstration purposes)
  Future<void> _saveUserData() async {
    await storage.write(key: 'name', value: 'John');
    await storage.write(key: 'surname', value: 'Doe');
    await storage.write(key: 'email', value: 'john.doe@example.com');
    await storage.write(key: 'dateInscription', value: '2023-10-01');
    _loadUserData(); // Reload data after saving
  }

  // Clear user data from SecureStorage (for demonstration purposes)
  Future<void> _clearUserData() async {
    await storage.delete(key: 'name');
    await storage.delete(key: 'surname');
    await storage.delete(key: 'email');
    await storage.delete(key: 'dateInscription');
    _loadUserData(); // Reload data after clearing
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Profile Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileItem('Name', name),
            _buildProfileItem('Surname', surname),
            _buildProfileItem('Email', email),
            _buildProfileItem('Registration Date', dateInscription),
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _saveUserData,
                    child: const Text('Save Example Data'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _clearUserData,
                    child: const Text('Clear Data'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(), name: '', // Assuming you have a BottomNavBar widget
    );
  }

  // Helper method to build a profile item row
  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}