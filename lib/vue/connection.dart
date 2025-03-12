import 'package:flutter/material.dart';
import 'package:forumfinal/vue/composant/bottomnavbar.dart';
import '../widgets/myscaffold.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      name: "Connexion",
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Bienvenue ! Connectez-vous pour accéder au forum.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              LoginForm(), // 📌 Le formulaire est maintenant dans un widget séparé
            ],
          ),
        ),
      ), bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}
