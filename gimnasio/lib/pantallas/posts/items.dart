import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gimnasio/Usuario.dart';
Acceso modo = new Acceso();
class Item extends StatelessWidget{
  String titulo, desc;
  int id;
  Item(this.titulo, this.desc, this.id);
  void eliminarItem(String id, var context) {//metodo para borrar el ejercicio
    http.delete('https://athlean-x-ba8ca.firebaseio.com/ejercicios/$id.json').then((http.Response res){
        Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Ejercicio borrado", style: TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 1, milliseconds: 500),
                                  ));
    });
  }

                     

  @override
  Widget build(BuildContext context){
  
    return Card(
                    child: Container(
                      width: 400.0,
                      height: 280.0,
                      child: new Column(
                        children: <Widget>[
                          Center(
                            child: new Text( 
                            titulo,
                            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),),
                          new Text( 
                            desc,
                            style: new TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.left,
                          ),
                          new Text( 
                            "Id: "+ id.toString(),
                            style: new TextStyle(fontSize: 20.0,),  
                          )
                        ],
                      ),
                    ),
                  );
  }
}
