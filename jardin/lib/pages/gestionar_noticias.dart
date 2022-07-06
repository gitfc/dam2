import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jardin/widgets/bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../services/firestore_service.dart';
import 'editar_noticia.dart';
import 'agregar_noticia.dart';

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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirestoreService().noticias(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    height: 0,
                    thickness: 0,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var noticia = snapshot.data!.docs[index];
                    String fecha = DateFormat('dd-MM-yy\nHH:mm').format(
                        DateTime.parse(noticia['fecha'].toDate().toString()));
                    return Card(
                      margin: EdgeInsets.all(5),
                      elevation: 3,
                      child: ListTile(
                        title: Text('${noticia['titulo']}'),
                        trailing: Text(
                          '$fecha',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Text(
                          '${noticia['contenido']}',
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => EditarNoticia(id: noticia.id),
                          );
                          Navigator.push(context, route);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(builder: (context) {
            return AgregarNoticia();
          });
          Navigator.push(context, route);
        },
        backgroundColor: Colors.red,
        child: Icon(MdiIcons.newspaperPlus),
      ),
    );
  }
}
