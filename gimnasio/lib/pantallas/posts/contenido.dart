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

      http.get('http://192.168.8.122/users/?format=json').then((http.Response res){
                      final List<Row> itemsBD = []; 
                        // Si el servidor devuelve una repuesta OK, parseamos el JSON
                        final List<dynamic> listaDatosLibros= json.decode(res.body); 
                        listaDatosLibros.forEach((dynamic datosPost){
                          print(datosPost['title']);
                          final Item itemBD = Item(
                                datosPost['username'],
                                datosPost['email'],
                                datosPost['id'] );
                                itemsBD.add(Row(children: <Widget>[itemBD],));
                                print(datosPost['title']);
       
                              
                                
                              setState(() {
                                items = itemsBD;
                              }); 
                        }); 
        
                      
                    });
    


  }
  @override
  Widget build(BuildContext context) {
    if(items==null)
    fetchItems(tipo);
    List<Widget> aMostrar = [];

    if(items==null){
      aMostrar.add(Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF2BD093))),));
    } 
    else aMostrar = items;
    
    return new ListView(
      children:aMostrar,
    );
  }
}
