import 'package:flutter/material.dart';
import 'package:gimnasio/Usuario.dart' as usuario;
import 'package:http/http.dart' as http;
import 'items.dart';
import 'dart:convert';
List<Row> items;
bool loading = true;
class Contenido extends StatefulWidget {
  String tipo;
  Contenido(this.tipo){
  }
  @override
  _Contenido createState() => new _Contenido(tipo);

}

class _Contenido extends State<Contenido> {

  String tipo;
  _Contenido(this.tipo);
  @override
  void dispose() {
    items = null;
    super.dispose();
  }
  void fetchItems(String tipo) {
    loading = true;
      http
          .get('https://athlean-x-ba8ca.firebaseio.com/ejercicios.json')
          .then((http.Response response) {
        final List<Row> itemsBD = [];
        final Map<String, dynamic> listaDeMascotas = json.decode(response.body);
        listaDeMascotas.forEach((String userid, dynamic datosRespuesta) {
          if(datosRespuesta['GrupoMuscular'] == tipo || tipo == "todos"){
            final Item itemBD = Item(
              datosRespuesta['Titulo'],
              datosRespuesta['Imagen'],
              datosRespuesta['Descripcion'],
              userid );
            itemsBD.add(Row(children: <Widget>[itemBD],));
          }
          
        });
        setState(() {
          items = itemsBD;
        });   
      });
    if(items != null && items.length > 0) 
    setState(() {
      loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    fetchItems(tipo);
    List<Widget> aMostrar = [];

    if(loading){
      aMostrar.add(Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF2BD093))),));
    } 
    else aMostrar = items;
    
    
    print(items);
    return new ListView(
      children:aMostrar,
    );
  }
}
