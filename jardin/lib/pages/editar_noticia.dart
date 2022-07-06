import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/firestore_service.dart';
import '../widgets/bar.dart';

class EditarNoticia extends StatefulWidget {
  final id;
  EditarNoticia({Key? key, required this.id}) : super(key: key);

  @override
  State<EditarNoticia> createState() => _EditarNoticiaState();
}

class _EditarNoticiaState extends State<EditarNoticia> {
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController contenidoCtrl = TextEditingController();
  TextEditingController fechaCtrl = TextEditingController();
  TextEditingController horaCtrl = TextEditingController();
  DateTime fecha = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barra("Editar noticia", context, false),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
            future: FirestoreService().getNoticia(widget.id),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var noticia = snapshot.data;
              tituloCtrl.text = noticia['titulo'];
              contenidoCtrl.text = noticia['contenido'];
              fecha = noticia['fecha'].toDate();
              fechaCtrl.text = DateFormat("dd MMMM yyyy",
                      Localizations.localeOf(context).toString())
                  .format(DateTime.parse(noticia['fecha'].toDate().toString()));
              horaCtrl.text = DateFormat('HH:mm:ss')
                  .format(DateTime.parse(noticia['fecha'].toDate().toString()));
              return ListView(
                children: [
                  TextFormField(
                    controller: tituloCtrl,
                    decoration: InputDecoration(
                      labelText: "Título",
                      prefixIcon: Icon(MdiIcons.nearMe),
                    ),
                  ),
                  TextFormField(
                    controller: contenidoCtrl,
                    decoration: InputDecoration(
                      labelText: "Contenido",
                      prefixIcon: Icon(MdiIcons.text),
                    ),
                    minLines: 1,
                    maxLines: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: fecha,
                        firstDate: DateTime(1990),
                        lastDate: DateTime.now(),
                        locale: Locale('es', 'ES'),
                      ).then(
                        (fechaNueva) {
                          fechaCtrl.text = DateFormat("dd MMMM yyyy",
                                  Localizations.localeOf(context).toString())
                              .format(fechaNueva!);
                          fecha = fechaNueva;
                        },
                      );
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: fechaCtrl,
                      decoration: InputDecoration(
                        labelText: "Fecha",
                        prefixIcon: Icon(MdiIcons.calendar),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: TextFormField(
                      enabled: false,
                      controller: horaCtrl,
                      decoration: InputDecoration(
                        labelText: "Hora",
                        prefixIcon: Icon(MdiIcons.clock),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Guardar cambios',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Color.fromARGB(255, 14, 62, 102);
                          return Colors.blue; // Use the component's default.
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Eliminar'),
                            content:
                                Text('¿Está seguro de eliminar esta noticia?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  FirestoreService()
                                      .noticiasEliminar(widget.id);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('Confirmar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancelar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Eliminar noticia',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
