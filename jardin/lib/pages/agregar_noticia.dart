import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/firestore_service.dart';
import '../services/statusbar.dart';
import '../widgets/bar.dart';

class AgregarNoticia extends StatefulWidget {
  AgregarNoticia({Key? key}) : super(key: key);

  @override
  State<AgregarNoticia> createState() => _AgregarNoticiaState();
}

class _AgregarNoticiaState extends State<AgregarNoticia> {
  final formKey = GlobalKey<FormState>();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController contenidoCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barra("Agregar noticia", context),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              TextFormField(
                controller: tituloCtrl,
                decoration: InputDecoration(
                  labelText: "Título",
                  prefixIcon: Icon(MdiIcons.nearMe),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: contenidoCtrl,
                decoration: InputDecoration(
                  labelText: "Contenido",
                  prefixIcon: Icon(MdiIcons.text),
                ),
                minLines: 8,
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    String titulo = tituloCtrl.text.trim();
                    String contenido = contenidoCtrl.text.trim();
                    Timestamp ts = Timestamp(
                        DateTime.now().millisecondsSinceEpoch ~/ 1000, 0);
                    FirestoreService().noticiasAgregar(titulo, contenido, ts);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Agregar noticia',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Color.fromARGB(255, 14, 62, 102);
                      return Colors.blue;
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancelar',
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Color.fromARGB(255, 128, 28, 21);
                      return Colors.red; // Use the component's default.
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.white; // Use the component's default.
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StatusBar(),
    );
  }
}
