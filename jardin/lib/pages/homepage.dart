import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'loginpage.dart';
import 'gestionar_noticias.dart';
import 'ver_noticias.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool logged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 248, 251),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: GradientText(
                    'Jardín Infantil Pequeño Arcoiris',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.pink,
                        Colors.purple,
                        Colors.deepPurple,
                        Colors.deepPurple,
                        Colors.indigo,
                        Colors.blue,
                        Colors.lightBlue,
                        Colors.cyan,
                        Colors.teal,
                        Colors.green,
                        Colors.lightGreen,
                        Colors.lime,
                        Colors.yellow,
                        Colors.amber,
                        Colors.orange,
                        Colors.deepOrange,
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Image.asset("lib/img/arcoiris.png"),
                  height: 250,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  );
                  Navigator.push(context, route);
                },
                label: Text(
                  'Iniciar sesión',
                  style: TextStyle(fontSize: 20),
                ),
                icon: Icon(MdiIcons.locationEnter),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.pink,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => GestionarNoticias(),
                  );
                  Navigator.push(context, route);
                },
                label: Text(
                  'Gestionar noticias',
                  style: TextStyle(fontSize: 20),
                ),
                icon: Icon(MdiIcons.newspaperCheck),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.pink,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => VerNoticias(),
                  );
                  Navigator.push(context, route);
                },
                label: Text(
                  'Ver noticias',
                  style: TextStyle(fontSize: 20),
                ),
                icon: Icon(MdiIcons.newspaperVariantMultipleOutline),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.pink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
