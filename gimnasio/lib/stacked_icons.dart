import 'package:flutter/material.dart';

class StakedIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Stack(
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
            );
  }
}//icono del logo principal
