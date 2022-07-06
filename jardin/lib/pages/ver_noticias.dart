import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jardin/services/firestore_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var noticia = snapshot.data!.docs[index];
                      String fecha = DateFormat('dd-MMM-yy').format(
                          DateTime.parse(noticia['fecha'].toDate().toString()));
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('${noticia['titulo']}'),
                              trailing: Text('$fecha'),
                              subtitle: Text('${noticia['contenido']}'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
