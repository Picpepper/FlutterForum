import 'package:flutter/material.dart';
import '../widgets/connexion_form.dart';
import '../widgets/myscaffold.dart';

class ConnexionVue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      name: 'Connexion',
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ConnexionForm(),
            ],
          ),
        ),
      ),
    );
  }
}
