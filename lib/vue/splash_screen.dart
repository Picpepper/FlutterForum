import 'dart:async';
import 'package:flutter/material.dart';
import 'accueil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // l'écran dure 4sec
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Accueil()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo ou icône
            Image.asset(
              'assets/splash_logo.png',
              width: 350,
            ),
            SizedBox(height: 20),
            // Cercle de chargement
            CircularProgressIndicator(
              color: Colors.blue, // Couleur du spinner
            ),
          ],
        ),
      ),
    );
  }
}
