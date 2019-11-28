
import 'package:flutter/material.dart';
import 'contenido.dart';
import 'package:gimnasio/Usuario.dart' as usuario;
usuario.ModoAcceso modo;
class Ejercicios extends StatefulWidget {
  String tipo;
  Ejercicios(this.tipo);
  @override
  _Ejercicios createState() => new _Ejercicios(tipo);
}

class _Ejercicios extends State<Ejercicios> {
  String tipo;
  _Ejercicios(this.tipo);
        int currentPage=5;
        @override
        Widget build(BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
        centerTitle: true,
          title: new Text("Ejercicios", style:  TextStyle(color:Colors.black ),),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      resizeToAvoidBottomPadding: false,
      body: Contenido(tipo),
    );
  }
}

