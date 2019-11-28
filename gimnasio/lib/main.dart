import 'package:flutter/material.dart';
import 'pantallas/inicioSesion/login.dart';
import 'package:flutter/services.dart';

void main() => runApp(QuickBee());

class QuickBee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Athlean X',
      debugShowCheckedModeBanner: false,
      // Set Raleway as the default app font
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),

      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black, //color de la barra de notificaciones
    ));
    return new Scaffold(
      bottomNavigationBar:null,//que no tiene navbar
      backgroundColor: Color.fromARGB(255, 255, 255, 255),//color de fondo del scaffold
      resizeToAvoidBottomPadding: false,//para evitar lo de que se pasan los pixeles
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,//todos centrados
          children: <Widget>[
            new Stack(//el icono, titulo y boton
              alignment: Alignment.center,
              children: <Widget>[
                new Container(
                  margin: new EdgeInsets.only(left: 0.0, top: 20.0),
                  height: 150.0,
                  width: 150.0,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(100.0),
                      color: Colors.black),
                  child: new Icon(
                    Icons.fitness_center,
                    color: Colors.white,  
                    size: 80.0,
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                  child: new Text(
                    "Athlean X",
                    style: new TextStyle(fontSize: 50.0),
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(
                           builder: (context) => LoginPage(),
                         ));//cuando se presiona se va a la pantalla de inicio de sesion
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFF18D191),
                              borderRadius: new BorderRadius.circular(9.0)),
                          child: new Text("Iniciar sesión",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
