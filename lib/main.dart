import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'vue/login_screen.dart';
import 'vue/accueil.dart';
import 'vue/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider()..loadSession(), // ✅ Charge le token ET le profil utilisateur
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // L'application démarre avec un splashscreen
      routes: {
        '/home': (context) => Accueil(), // Accès libre au forum
        '/login': (context) => LoginScreen(), // Connexion facultative
      },
    );
  }
}
