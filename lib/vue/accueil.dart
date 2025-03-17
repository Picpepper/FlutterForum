import 'package:flutter/material.dart';
import 'composant/appbar.dart';
import 'composant/bottomnavbar.dart';
import 'composant/drawer.dart';
import 'messages_screen.dart'; // Assurez-vous d'importer votre fichier messages_screen.dart

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int _selectedIndex = 0; // Index de l'onglet sélectionné

  // Liste des écrans à afficher
  final List<Widget> _screens = [
    Center(child: Text("Bienvenue sur la page d'accueil !", style: TextStyle(fontSize: 24))),
    MessageScreen(), // Assurez-vous que MessageScreen est bien défini
    Center(child: Text("Profil", style: TextStyle(fontSize: 24))), // Exemple pour le profil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Met à jour l'index sélectionné
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: _screens[_selectedIndex], // Affiche l'écran sélectionné
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}