import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../vue/connexion.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final String name;
  const MyScaffold({
    Key? key,
    required this.body,
    required this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(this.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        elevation: 10.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.app_registration, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/inscription',
              );
            },
          ),
          IconButton(
            icon: Icon(
              authProvider.isAuthenticated ? Icons.logout : Icons.login,
              color: Colors.white,
            ),
            onPressed: () {
              if (authProvider.isAuthenticated) {
                authProvider.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/connexion',
                  (Route<dynamic> route) => false,
                );
              } else {
                Navigator.pushNamed(
                  context,
                  '/connexion',
                );
              }
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
