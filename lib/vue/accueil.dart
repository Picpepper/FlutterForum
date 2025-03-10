import 'package:flutter/material.dart';
import 'composant/appbar.dart';
import 'composant/bottomnavbar.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenue sur la page d'accueil !",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              "...",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}