import 'package:flutter/material.dart';
import 'authCard.dart';
import '../../stacked_icons.dart';




class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}


class _LoginPage extends State<LoginPage> {
  
  TextEditingController cuenta=TextEditingController(), contrasenia=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar:null,
      appBar: new AppBar( //appbar
        backgroundColor:Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      body: Container(
        width: double.infinity,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new StakedIcons(),//logo principal
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                  child: new Text(
                    "Inicio de sesión",//titulo
                    style: new TextStyle(fontSize: 30.0),
                  ),
                )
              ],
            ),
            AuthCard(),//contenido
          ],
        ),
      ),
    );
  }
}
