import 'package:flutter/material.dart';
import 'package:forumfinal/widgets/myscaffold.dart';
import 'package:forumfinal/widgets/inscription_form.dart';

class InscriptionVue extends StatefulWidget {
  const InscriptionVue({super.key});
  @override
  State<StatefulWidget> createState() {
    return _InscriptionVue();
  }
}

class _InscriptionVue extends State<InscriptionVue> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(name: 'Inscription', body: InscriptionForm());
  }
}
