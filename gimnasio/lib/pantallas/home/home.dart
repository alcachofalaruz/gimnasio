import 'package:flutter/material.dart';
import 'package:gimnasio/pantallas/inicioSesion/authCard.dart';
import '../ejercicios/ejercicios.dart';
class HomePage extends StatefulWidget {
  HomePage(){}
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
        int currentPage=0;
        @override
        Widget build(BuildContext context) {
          return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Contenido(),
    );
  }
}

class Item extends StatelessWidget{//los ejercicios que aparecen
  String imagen, titulo;
  Item(this.titulo, this.imagen);
  @override
  Widget build(BuildContext contex){
    return Expanded(
                    child: Container(
                      height: 150.0,
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            height: 100.0,
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new NetworkImage(//obtengo la imagen de internet
                                        imagen),
                                    fit: BoxFit.cover)),
                          ),
                          new Text(
                            titulo,
                            style: new TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  );
  }
}

class Contenido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: new Container(
              child: new Column(
            children: <Widget>[
              new SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  new Expanded(
                      child:  new Text("Abdominales",
                          style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ))),
                  new Expanded(
                      child: FlatButton (onPressed: (){  Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Ejercicios("abdomen"),//si aprietan en mostrar mas se abre en la categoria de abdomen
                          ));}, child:Align(
                    alignment: Alignment.centerRight,
                    child: new Text(
                    "mostrar todos",
                    style: new TextStyle(color: Color(0XFF2BD093)),
                    textAlign: TextAlign.left
              )))),
                ],
              ),
              new SizedBox(
                height: 10.0,
              ),
              Row(//la lista de ejercicios
                children: <Widget>[
                  Item("Ab Wheel Rollout",'https://www.mensjournal.com/wp-content/uploads/2018/03/abwheelrollout.jpg?w=800'),
                  new SizedBox(
                    width: 5.0,
                  ),
                  Item("Barbell Russian Twist", 'https://www.mensjournal.com/wp-content/uploads/2018/03/barbell-russian-twist.jpg?w=800'),
                  new SizedBox(
                    width: 5.0,
                  ),
                  Item('Swiss Ball V-Up and Pass',  'https://www.mensjournal.com/wp-content/uploads/2018/03/30-best-ab-exercises-toe-touch_0-1.jpg?w=800'),
                
                ],
              ),
              new SizedBox(
                height: 15.0,
              ),
              Row(
                children: <Widget>[
                  new Expanded(
                      child: new Text("biceps",
                          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold) )),
                   new Expanded(
                      child: FlatButton (onPressed: (){  Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Ejercicios("biceps"),
                          ));}, child:Align(
              alignment: Alignment.centerRight,
              child: new Text(
                    "mostrar todos",
                    style: new TextStyle(color: Color(0XFF2BD093)),
                    textAlign: TextAlign.left
              )))),
                ],
              ),
              new SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Item("Standing Dumbbell Curl", 'https://bodybuilding-wizard.com/wp-content/uploads/2014/05/alternating-standing-dumbbell-biceps-curls-2-3-4.jpg'),
                  new SizedBox(
                    width: 5.0,
                  ),
                  Item("Incline Dumbbell Curl", 'https://i.ytimg.com/vi/UeleXjsE-98/maxresdefault.jpg'),
                  new SizedBox(
                    width: 5.0,
                  ),
                  Item('Hammer Curl', 'https://cdn-ami-drupal.heartyhosting.com/sites/muscleandfitness.com/files/fat-grip-hammer-curl-exercise_landscape.jpg'),
                ],
              ),
              new SizedBox(
                height: 15.0,
              ),
              Row(
                children: <Widget>[
                  new Expanded(
                      child: new Text("  espalda",
                          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
                   new Expanded(
                      child: FlatButton (onPressed:(){  Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Ejercicios("espalda"),
                          ));}, child:Align(
              alignment: Alignment.centerRight,
              child: new Text(
                    "mostrar todos",
                    style: new TextStyle(color: Color(0XFF2BD093)),
                    textAlign: TextAlign.left
              )))),
                ],
              ),
              new SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Item("lat pulldown", 'https://cdn1.coachmag.co.uk/sites/coachmag/files/2019/01/lat-pull-down.jpg'),
                  new SizedBox(
                    width: 5.0,
                  ),
                  Item("pull up", 'https://onnitacademy.imgix.net/2016/02/pullups-1440x900.png'),
                  new SizedBox(
                    width: 5.0,
                  ),
                  Item('deadlift','https://www.t-nation.com/system/publishing/articles/10005894/original/The-5-Most-Dangerous-Deadlift-Mistakes.jpg?1517861498' ),
                ],
              )
            ],
          )),
        )
      ],
    );
  }
}
