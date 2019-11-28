import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../stacked_icons.dart';

class AgregarItemScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AgregarItemScreen();
  }
}

class _AgregarItemScreen extends State<AgregarItemScreen> {
  List<String> grupoMuscular = ["espalda", "pecho", "abdomen", "piernas", "biceps", "triceps"];
  String tipoGrupoMuscular = "Grupo Muscular";
  TextEditingController titulo=TextEditingController(), url=TextEditingController(), desc=TextEditingController();
  @override
  Widget build(BuildContext context) {
    try {

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar:null,
      body: SingleChildScrollView(child: Container(
        width: double.infinity,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new StakedIcons(),
            
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                  child: new Text(
                    "Agregar producto",
                    style: new TextStyle(fontSize: 30.0),
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                decoration: new InputDecoration(labelText: 'Titulo'),
                controller: titulo,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            new SizedBox(
              height: 15.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                decoration: new InputDecoration(labelText: 'Descripción...'),
                controller: desc,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            new SizedBox(
              height: 15.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  
              child: new TextField(
                decoration: new InputDecoration(labelText: 'Url', ),
                controller: url,
              ),
            ),
            new SizedBox(
              height: 15.0,
            ),
            Align(
                  
                  alignment: Alignment.centerLeft,
                  child: Container(padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  child: DropdownButton<String>(
              items:grupoMuscular.map((String val){
                return DropdownMenuItem<String>(
                  value: val,
                  child: new Text(val),
                );
              }).toList(),
              hint:Text(tipoGrupoMuscular, style: TextStyle(color: Colors.black),),
              onChanged:(String val){
                
                setState(() {
                  tipoGrupoMuscular= val;
                });
                }),)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 5.0, top: 10.0),
                    child: GestureDetector(
                      onTap: ()  {
                        if(!(titulo.text == "" || url.text == "" || tipoGrupoMuscular == "Grupo Muscular" || desc.text == "")){
                          final Map<String, dynamic> data = {
                          'Titulo': titulo.text,
                          'Imagen': url.text,
                          'GrupoMuscular': tipoGrupoMuscular,
                          'Descripcion': desc.text,
                        };
                        setState(() {
                          Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Cargando dato...', style: TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.yellow,
                                    duration: Duration(seconds: 1, milliseconds: 500),
                                    
                                  ));

                        });
                          http.post("https://athlean-x-ba8ca.firebaseio.com/ejercicios.json", body:  json.encode(data)).then((http.Response res){
                          setState(() {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Cargado'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 1, milliseconds: 500),
                                  ));
                          });
                          
                        });
                        }
                        
                        else{
                          Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Por favor ingrese todos los datos.'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1, milliseconds: 500),
                                  ));
                        }
                        
                        
                        
                      },
                                          child: new Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            decoration: new BoxDecoration(
                                color: Color(0xFF18D191),
                                borderRadius: new BorderRadius.circular(9.0)),
                            child: new Text("Cargar ejercicio",
                                style: new TextStyle(
                                    fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));

    } catch (e) {

      return Text("error kk");

    }
    
  }
}