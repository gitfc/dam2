import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jardin/services/firestore_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'ver_noticia.dart';

class VerNoticias extends StatefulWidget {
  VerNoticias({Key? key}) : super(key: key);

  @override
  State<VerNoticias> createState() => _VerNoticiasState();
}

class _VerNoticiasState extends State<VerNoticias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ver noticias"),
        backgroundColor: Color.fromARGB(255, 255, 137, 176),
        leading: BackButton(),
        automaticallyImplyLeading: true,
      ),
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
                    String fechaLarga = DateFormat(
                            'EEEE, dd MMMM yyyy, HH:mm:ss',
                            Localizations.localeOf(context).toString())
                        .format(DateTime.parse(
                            noticia['fecha'].toDate().toString()));
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
                            builder: (context) => VerNoticia(
                              titulo: noticia['titulo'],
                              contenido: noticia['contenido'],
                              fecha: fechaLarga,
                            ),
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
    );
  }
}
