import 'package:flutter/material.dart';
import 'package:gimnasio/TodosLosEjercicios.dart' as ejercicios;
import 'package:gimnasio/pantallas/ejercicios/contenido.dart';
import 'pantallas/home/home.dart' as page;
import 'pantallas/calculadora/calculadora.dart';
import 'pantallas/agregarEjercicio/agregarItem.dart';
import 'Usuario.dart';
import 'pantallas/agregarEjercicio/agregarItem.dart';
import 'pantallas/posts/ejercicios.dart' as post;
Acceso modo = Acceso();
class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
} //clase para los elementos que aparecen en el menu 

class Menu extends StatefulWidget {
    List <DrawerItem> drawerItems = [];
  Menu(){
    drawerItems  = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Calculadora Calorica", Icons.fastfood),
    new DrawerItem("Ejercicios", Icons.fitness_center),
    
  ];
  if (modo.modo == ModoAcceso.Admin) {
      drawerItems.add( new DrawerItem("Agregar Ejercicio", Icons.add));
    }
  }
  //las opciones del menu
  @override
  State<StatefulWidget> createState() {
    
    return new MenuState();
  }
}

class MenuState extends State<Menu> {
  int _selectedDrawerIndex = 0;
  MenuState();
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return page.HomePage();
      case 1:
        return post.Ejercicios("f");
      case 2:
        return  ejercicios.Filtros("todos");
      case 3:
        if (modo.modo == ModoAcceso.Admin) {
          return AgregarItemScreen();
        }
        break;
      default:
        return new Text("Error");
    }
  }//dependiendo en el elemento que eligas va a devolver una pantalla, en caso de no ser una opcion valida devuelve una de error
  
  _onSelectItem(int index) {
    print(modo.modo);
    setState(() => _selectedDrawerIndex = index);//establece numero del elemento seleccionado
    Navigator.of(context).pop(); // cierro el menu
  }//metodo a llamar cuando se selecciona un elemento del menu

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      print(i);
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon, color: Color(0xFF18D191),),
          title: new Text(d.title, style: TextStyle(color: Colors.black),),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }//crea los elementos del menu

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
          title: new Text(widget.drawerItems[_selectedDrawerIndex].title, style:  TextStyle(color:Colors.black ),),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      drawer: new Drawer(
        
        child: new Column(
          children: <Widget>[
              new UserAccountsDrawerHeader(//encabezado del menu, muestra el nombre de cuenta y el correo
                decoration: BoxDecoration(
                    color: Color(0xFF18D191),
                ),
                accountName: new Text(modo.usuario.nombre), accountEmail: Text(modo.usuario.email)),            
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),//metodo que devuelve la pantalla que se va a mostrar
    );
  }
}