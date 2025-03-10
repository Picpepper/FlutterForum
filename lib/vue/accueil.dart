import 'package:flutter/material.dart';
import 'composant/appbar.dart';
import 'composant/bottomnavbar.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text("Bienvenue sur la page d'accueil !", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}
