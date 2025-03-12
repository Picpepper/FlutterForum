import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../utils/secure_storage.dart'; // Import your SecureStorage class
import '../connection.dart'; // Import your LoginScreen
import '../inscription.dart'; // Import your RegisterScreen

class CustomDrawer extends StatelessWidget {
  final SecureStorage secureStorage = SecureStorage(); // Correct instantiation

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: secureStorage.readUserInfo(), // Fetch user info from SecureStorage
      builder: (BuildContext context, AsyncSnapshot<Map<String, String?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Drawer(
            child: Center(child: CircularProgressIndicator()), // Show a loading indicator
          );
        }

        if (snapshot.hasError) {
          return Drawer(
            child: Center(child: Text("Erreur de chargement des informations de l'utilisateur")),
          );
        }

        // Retrieve user info
        final userInfo = snapshot.data ?? {};
        final String? userNom = userInfo['nom'];
        final String? userPrenom = userInfo['prenom'];
        final String? userEmail = userInfo['email']; // Fetch email from user info

        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.purple),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                      radius: 30,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userNom != null && userPrenom != null
                              ? "$userNom $userPrenom"
                              : "Invité", // Display full name if available, otherwise "Invité"
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          userEmail ?? "email@example.com", // Display email if available, otherwise a placeholder
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Conditional display of ListTiles based on user info
              if (userEmail == null) ...[
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Inscription'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.login),
                  title: Text('Connexion'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ] else ...[
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Déconnexion', style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    await secureStorage.deleteUserInfo(); // Clear all user data from SecureStorage
                    Navigator.pushReplacementNamed(context, '/'); // Redirect to home or login screen
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}