import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            blurStyle: BlurStyle.outer,
            color: Colors.black,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(3),
        child: FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot snap) {
            if (!snap.hasData) {
              return Text(
                '...',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              );
            }
            return Text(
              snap.data,
              style: TextStyle(
                color: Color.fromARGB(255, 66, 66, 66),
              ),
            );
          },
        ),
      ),
    );
  }
}

Future<String> getData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var str = null;
  if (pref.getString('user') != null) {
    return 'Conectado como ' + pref.getString('user').toString();
  } else {
    return 'Sesión anónima. No se ha iniciado sesión.';
  }
}
