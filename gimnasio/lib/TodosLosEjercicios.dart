import 'package:flutter/material.dart';
import 'package:gimnasio/pantallas/inicioSesion/authCard.dart';
import 'pantallas/ejercicios/ejercicios.dart' as ej;


class Filtros extends StatefulWidget {
  String tipo;
  Filtros(this.tipo);
  @override
  _Filtros createState() => new _Filtros(tipo);
}
String tipoGrupoMuscular = "todos";
class _Filtros extends State<Filtros> {
  List<String> grupoMuscular = ["espalda", "pecho", "abdomen", "piernas", "biceps", "triceps", "todos"];
  
  String tipo;
  _Filtros(this.tipo);
        int currentPage=5;
        @override
        Widget build(BuildContext context) {
          print(tipoGrupoMuscular);
          return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  height: MediaQuery.of(context).size.height * 1,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                      itemCount: grupoMuscular.length, itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            child: ListTile(title: Text(grupoMuscular[index], style: TextStyle(color: Colors.black, fontSize:35.0)),onTap: (){
                              
                              Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => ej.Ejercicios(grupoMuscular[index]),//se llama la pantalla del ejercicio dependiendo del musculo elegido
                              ));
                            },
                            trailing: Icon(Icons.arrow_forward, color: Color(0XFF2BD093),),)
                               
                            ),
                          );
                    }),),
         ])),
    );
  }
}