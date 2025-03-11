import 'package:flutter/material.dart';
import '../connection.dart'; // ✅ Import de l'écran de connexion
import '../inscription.dart'; // ✅ Import de l'écran d'inscription

class AuthentificationChoix extends StatelessWidget {
  const AuthentificationChoix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenue sur le Forum"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.forum, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "Bienvenue sur notre forum !",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // ✅ Bouton pour aller à la connexion
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text("Se Connecter"),
            ),
            SizedBox(height: 10),
            // ✅ Bouton pour aller à l'inscription
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text("S'inscrire"),
            ),
          ],
        ),
      ),
    );
  }
}
