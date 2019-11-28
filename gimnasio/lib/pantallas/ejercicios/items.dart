import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gimnasio/Usuario.dart';
Acceso modo = new Acceso();
class Item extends StatelessWidget{
  String imagen, titulo, desc, id;
  Item(this.titulo, this.imagen, this.desc, this.id);
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
    var delete = (modo.modo == ModoAcceso.Admin)? IconButton(
                            alignment: Alignment.centerLeft,
                            onPressed:(){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Borrando ejercicio...", style: TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 1, milliseconds: 500),
                                  ));
                                    eliminarItem(id, context);//cada objeto almacena su id asi que solo tengo que llamar eliminar el item con su propia ID

                          } , icon: Icon(Icons.delete),): Container();  
    final img = new NetworkImage(imagen, );
    print(img);
    return Card(
                    child: Container(
                      width: 400.0,
                      height: 400.0,
                      child: new Column(
                        children: <Widget>[
                          Center(child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[new Text( 
                            titulo,
                            style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ), delete], ),),
                          new Container(
                            width: 350.0,
                            height: 225.0,
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(15.0),
                                image: new DecorationImage(
                                    image: img,
                                    fit: BoxFit.cover)),  
                          ),
                          new Text( 
                            "Descripcion: "+ desc,
                            style: new TextStyle(fontSize: 20.0,),
                            textAlign: TextAlign.center,
                          ),
                          new Text( 
                            "Id: "+ id,
                            style: new TextStyle(fontSize: 20.0,),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  );
  }
}
