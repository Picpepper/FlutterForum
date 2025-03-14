import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/utilisateur.dart';
import '../providers/auth_provider.dart';
import '../utils/secure_storage.dart';

class ConnexionForm extends StatefulWidget {
  const ConnexionForm({super.key});

  @override
  _ConnexionFormState createState() => _ConnexionFormState();
}

class _ConnexionFormState extends State<ConnexionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final SecureStorage secureStorage = SecureStorage();
  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    final credentials = await secureStorage.readCredentials();
    setState(() {
      _emailController.text = credentials['email'] ?? '';
      _passwordController.text = credentials['password'] ?? '';
    });
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await connecterUtilisateur(
          _emailController.text, _passwordController.text);
      final responseData = json.decode(response.body);
      await secureStorage.saveCredentials(
          _emailController.text, _passwordController.text);
      await secureStorage.saveToken(responseData['token']);
      Provider.of<AuthProvider>(context, listen: false)
          .login(_emailController.text, _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentification réussie')),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/accueil');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Echec de l\'authentification $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrez votre email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Mot de passe'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrez votre mot de passe';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          _isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _login();
                    }
                  },
                  child: Text('Connexion'),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
