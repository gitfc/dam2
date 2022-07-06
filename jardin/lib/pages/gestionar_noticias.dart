import 'package:flutter/material.dart';
import 'package:jardin/widgets/bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GestionarNoticias extends StatefulWidget {
  GestionarNoticias({Key? key}) : super(key: key);

  @override
  State<GestionarNoticias> createState() => _GestionarNoticiasState();
}

class _GestionarNoticiasState extends State<GestionarNoticias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barra("Gestionar noticias", context, false),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: null,
      ),
    );
  }
}
