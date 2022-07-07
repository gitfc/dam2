import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/statusbar.dart';

class VerNoticia extends StatefulWidget {
  final String titulo;
  final String contenido;
  final String fecha;

  VerNoticia(
      {Key? key,
      required this.titulo,
      required this.contenido,
      required this.fecha})
      : super(key: key);

  @override
  State<VerNoticia> createState() => _VerNoticiaState();
}

class _VerNoticiaState extends State<VerNoticia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.titulo}"),
        backgroundColor: Color.fromARGB(255, 255, 137, 176),
        leading: BackButton(),
        automaticallyImplyLeading: true,
      ),
      body: Card(
        margin: EdgeInsets.all(10),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: RichText(
            text: TextSpan(
              text: '',
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: '${widget.titulo}\n\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '${widget.fecha}\n\n',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                TextSpan(
                  text: '${widget.contenido}',
                  style: TextStyle(height: 1.5, fontSize: 17),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
