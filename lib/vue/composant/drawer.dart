import 'package:flutter/material.dart';
import '../../utils/secure_storage.dart' show SecureStorage;
import '../connection.dart'; // Assurez-vous que cela importe votre LoginScreen
import '../inscription.dart'; // Assurez-vous que cela importe votre RegisterScreen

class CustomDrawer extends StatelessWidget {
  final SecureStorage secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: secureStorage.readUserInfo(), // Asynchronously read user info
      builder: (BuildContext context, AsyncSnapshot<Map<String, String?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Drawer(
            child: Center(child: CircularProgressIndicator()), // Affiche un indicateur de chargement
          );
        }

        if (snapshot.hasError) {
          return Drawer(
            child: Center(child: Text("Erreur de chargement des informations de l'utilisateur")),
          );
        }

        // Récupérer le nom et le prénom de l'utilisateur
        String? userNom = snapshot.data?['userNom'];
        String? userPrenom = snapshot.data?['userPrenom'];

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
                              ? "Utilisateur: $userNom $userPrenom"
                              : "Utilisateur",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "email@example.com", // Remplacez ceci par l'email réel si disponible
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Affichage conditionnel des ListTiles en fonction de la présence des informations utilisateur
              if (userNom == null || userPrenom == null) ...[
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
                  onTap: () {
                    // Logique de déconnexion
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