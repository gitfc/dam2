import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../pages/homepage.dart';

AppBar barra(String titulo, BuildContext context, bool esMain) {
  return AppBar(
    title: Text(titulo),
    backgroundColor: Color.fromARGB(255, 255, 137, 176),
    leading: esMain ? Icon(MdiIcons.grid) : BackButton(),
    automaticallyImplyLeading: true,
    actions: [
      IconButton(
        icon: Icon(MdiIcons.logout),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => HomePage(),
          );
          Navigator.pushReplacement(context, route);
        },
      ),
    ],
  );
}
