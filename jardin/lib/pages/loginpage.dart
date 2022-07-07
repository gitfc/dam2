import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesión'),
        backgroundColor: Color.fromARGB(255, 255, 137, 176),
        leading: BackButton(),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: [
            Flexible(
              flex: 1,
              child: ExpansionTile(
                title: Text('Ingresar con correo electrónico'),
                leading: Icon(MdiIcons.email),
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: emailCtrl,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter(' ', allow: false),
                      ],
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Correo',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      controller: passwordCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contraseña',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Color.fromARGB(255, 138, 19, 58);
                          return Colors.pink; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () async {
                      UserCredential? cred;
                      try {
                        cred = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailCtrl.text.trim().toLowerCase(),
                          password: passwordCtrl.text.trim(),
                        );

                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setString(
                            'user', emailCtrl.text.trim().toLowerCase());

                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) => HomePage());

                        Navigator.pushReplacement(context, route);
                        setState(() {});
                      } on FirebaseAuthException catch (ex) {
                        error = 'Error: ';

                        switch (ex.code) {
                          case 'user-not-found':
                            error += 'Usuario no encontrado';
                            break;
                          case 'wrong-password':
                            error += 'Contraseña incorrecta';
                            break;
                          case 'user-disabled':
                            error += 'Usuario desactivado';
                            break;
                          case 'invalid-email':
                            error += 'Correo no válido';
                            break;
                          default:
                            if (emailCtrl.text.trim() == '') {
                              error += 'Por favor ingresa un correo';
                            } else if (passwordCtrl.text.trim() == '') {
                              error += 'Por favor ingresa una contraseña';
                            } else {
                              error += 'Error desconocido';
                            }
                        }

                        setState(() {});
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: error != ''
                        ? Text(
                            error,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.transparent,
              thickness: 5,
            ),
            ExpansionTile(
              leading: Icon(MdiIcons.cardAccountDetails),
              title: Text('Ingresar con redes sociales'),
              children: [
                Wrap(
                  spacing: 5,
                  alignment: WrapAlignment.center,
                  children: [
                    Card(
                      child: InkWell(
                        splashColor: Colors.pinkAccent,
                        onTap: () {},
                        child: Icon(MdiIcons.github, size: 120),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.pinkAccent,
                        onTap: () {},
                        child: Icon(MdiIcons.google, size: 120),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.pinkAccent,
                        onTap: () {},
                        child: Icon(MdiIcons.facebook, size: 120),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.pinkAccent,
                        onTap: () {},
                        child: Icon(MdiIcons.apple, size: 120),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.pinkAccent,
                        onTap: () {},
                        child: Icon(MdiIcons.microsoft, size: 120),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.pinkAccent,
                        onTap: () {},
                        child: Icon(MdiIcons.twitter, size: 120),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.pinkAccent,
                        onTap: () {},
                        child: Icon(MdiIcons.yahoo, size: 120),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.pinkAccent,
                        onTap: () {},
                        child: Icon(MdiIcons.twitch, size: 120),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
