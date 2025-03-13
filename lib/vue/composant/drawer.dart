import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    bool isAuthenticated = authProvider.isAuthenticated;
    final user = authProvider.user;

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
                    if (isAuthenticated) ...[
                      Text(
                        "${user?['pseudonyme']}",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "${user?['email']}",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ] else ...[
                      Text(
                        "Utilisateur",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "Non connecté",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),

          // Boutons affichés si l'utilisateur n'est PAS connecté
          if (!isAuthenticated) ...[
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Inscription'),
              onTap: () {
                Navigator.pushNamed(context, '/inscription');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Connexion'),
              onTap: () {
                Navigator.pushNamed(context, '/connexion');
              },
            ),
          ],

          // Bouton affiché si l'utilisateur EST connecté
          if (isAuthenticated)
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Déconnexion', style: TextStyle(color: Colors.red)),
              onTap: () {
                authProvider.logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Déconnecté avec succès")),
                );
                Navigator.pop(context); // Ferme le drawer
              },
            ),
        ],
      ),
    );
  }
}
