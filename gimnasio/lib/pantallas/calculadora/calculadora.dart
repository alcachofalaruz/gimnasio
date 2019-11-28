import 'package:flutter/material.dart';


List<Widget> listViews = List<Widget>();

class Calculadora extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Calculadora();
  }
}
//resultados
double bmr = 0.0, tdee = 0.0, proteinas = 0.0, carbohidratos = 0.0, grasas = 0.0, caloriasTotales = 0.0;
class _Calculadora extends State<Calculadora> {
  //controladores
  TextEditingController peso=TextEditingController(), edad=TextEditingController(),altura=TextEditingController();
  //las opciones
  List<String> _genero = ["Hombre", "Mujer"];
  List<String> _objetivo = ["perder peso lentamente(-10%)", "perder peso(-%20)", "mantener peso(%0)", "ganar peso lentamente(+10%)", "ganar peso(+%20)"];
  List<String> _nivelDeActividad = ["sedentario", "ligeramente activo", "moderadamente activo", "muy activo", "Extremadamente activo"];
  List<String> _cantProteina = [ "0.82g por libra","1g por libra", "1.5g por libra"];
  //los tipos seleccionados
  String _selectdType = "Genero";
  String _tipoObjetivo = "Objetivo";
  String _tipoNivelActividad = "Nivel de actividad";
  String _tipoProteina = "Cuenta proteina?";
  //los modificadores en los que se basan las cuentas
  double porcentajeCarb = 50.0;
  double modActividad, modProteina, modCarb, modEdad, modPeso, modAltura, modGenero, modObjetivo;
  void dispose() {//metodo destructor para que se reseteen los valores una vez se salga de la pantalla
    proteinas = 0.0;
    carbohidratos = 0.0;
    grasas = 0.0;
    tdee = 0.0;
    bmr = 0.0;
    caloriasTotales = 0.0;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    List<ItemInfo> items = [ItemInfo("BMR", bmr),ItemInfo("TDEE", tdee),ItemInfo("calorias diarias", caloriasTotales),ItemInfo("proteina", proteinas),ItemInfo("carbs", carbohidratos),ItemInfo("grasas", grasas),];
    print(proteinas);
    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar:null,
      body: SingleChildScrollView(child: Container(
        width: double.infinity,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
                  alignment: Alignment.centerLeft,
                  child: Container(padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0), child: Text("Stats",
                          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,),
                          textAlign: TextAlign.center, )) ,
                ),
           
            new SizedBox(
              height: 1.0,
            ),
            
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                decoration: new InputDecoration(labelText: 'peso(kg)'),
                controller: peso,
                keyboardType: TextInputType.number,
              ),
            ),),
            Expanded(child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                decoration: new InputDecoration(labelText: 'edad'),
                controller: edad,
                keyboardType: TextInputType.number,
              ),
            ),),
            Expanded(child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: new TextField(
                decoration: new InputDecoration(labelText: 'altura(cm)'),
                controller: altura,
                keyboardType: TextInputType.number,
              ),
            ),)
              ]
            ),
            new SizedBox(
              height: 15.0,
            ),
            Align(
                  
                  alignment: Alignment.centerLeft,
                  child: Container(padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  child: DropdownButton<String>(
              items:_genero.map((String val){
                return DropdownMenuItem<String>(
                  value: val,
                  child: new Text(val),
                );
              }).toList(),
              hint:Text(_selectdType, style: TextStyle(color: Colors.black),),
              onChanged:(String val){
                _selectdType= val;
                
                setState(() {
                  //una vez seleccionada la opcion, se establecen los valores de los modificadores, parecido con los otros selectores
                  if(val == _genero[0])  {
                    modGenero = 66;
                    modAltura = 5.0;
                    modPeso = 13.7;
                    modEdad = 6.8;
                  }
                  else{
                    modGenero = 655;
                    modAltura = 1.8;
                    modPeso = 9.6;
                    modEdad = 4.7;
                  }
                });
                }),)),
            new SizedBox(
              height: 5.0,
            ),
      
            Align(
                  
                  alignment: Alignment.centerLeft,
                  child: Container(padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0), child: Text("Modificadores",
                          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,),
                          textAlign: TextAlign.center, )) ,
                ),

              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                  child: DropdownButton<String>(
              items:_nivelDeActividad.map((String val){
                return DropdownMenuItem<String>(
                  value: val,
                  child: new Text(val),
                );
              }).toList(),
              hint:Text(_tipoNivelActividad, style: TextStyle(color: Colors.black),),
              onChanged:(String val){
                _tipoNivelActividad= val;
                setState(() {
                  if(val == _nivelDeActividad[0]) modActividad = 1.2;
                  else if(val == _nivelDeActividad[1]) modActividad = 1.375;
                  else if(val == _nivelDeActividad[2]) modActividad = 1.55;
                  else if(val == _nivelDeActividad[3]) modActividad = 1.725;
                  else if(val == _nivelDeActividad[4]) modActividad = 1.9;
                });
                }),)),

            new SizedBox(
              height: 7.0,
            ),
                
            Align(
                  alignment: Alignment.centerLeft,
                  child: Container(padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                  child: DropdownButton<String>(
              items:_cantProteina.map((String val){
                return DropdownMenuItem<String>(
                  value: val,
                  child: new Text(val),
                );
              }).toList(),
              hint:Text(_tipoProteina, style: TextStyle(color: Colors.black),),
              onChanged:(String val){
                _tipoProteina= val;
                if(_tipoProteina == _cantProteina[0]) modProteina = .82;
                else if(_tipoProteina == _cantProteina[1]) modProteina = 1;
                else if(_tipoProteina == _cantProteina[2]) modProteina = 1.5;
                setState(() {});
                }),)),
                
             Align(
                  
                  alignment: Alignment.centerLeft,
                  child: Container(padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                  child: DropdownButton<String>(
                    
              items:_objetivo.map((String val){
                return DropdownMenuItem<String>(
                  value: val,
                  child: new Text(val),
                );
              }).toList(),
              hint:Text(_tipoObjetivo, style: TextStyle(color: Colors.black),),
              onChanged:(String val){
                _tipoObjetivo= val;
                if(_tipoObjetivo == _objetivo[0]) modObjetivo = .8;
                else if(_tipoObjetivo == _objetivo[1]) modObjetivo = .9;
                else if(_tipoObjetivo == _objetivo[2]) modObjetivo = 1;
                else if(_tipoObjetivo == _objetivo[3]) modObjetivo = 1.1;
                else if(_tipoObjetivo == _objetivo[4]) modObjetivo = 1.2;
                setState(() {});
                }),)),
              
              new SizedBox(
              height: 7.0,
              ),
                Row(children: <Widget>[
                   Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, ),
                        //barra slider para seleccionar el porcentaje de carbohidratos/grasa
                    child:Text("Carb %" + porcentajeCarb.round().toString())),
                  Expanded(child: 
                    Slider(min: 1, max: 99, value: porcentajeCarb, label: "Carbs/fat ", activeColor: Color(0xFF18D191), onChanged: (double newValue) {
                    setState(() {
                      porcentajeCarb = newValue;
                    });
                  },),),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0, ),
                    child:Text("grasa %" + (100 - porcentajeCarb.round()).toString())),
                ],),

              Align(
                  
                  alignment: Alignment.centerLeft,
                  child: Container(padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0), child: Text("Resultados",
                          style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,),
                          textAlign: TextAlign.center, )) ,
                ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 5.0, top: 10.0),
                    child: GestureDetector(
                      onTap: ()  {
                        setState(() {
                          try {
                            //cuentas para calcular todo, son basadas en formulas para el bmr, tdee, y nivel de actividad
                            bmr = modGenero + (modPeso * double.parse(peso.text)) + (modAltura * double.parse(altura.text)) - (modEdad * double.parse(edad.text));
                            tdee = bmr * modActividad;
                            caloriasTotales = tdee * modObjetivo;
                            var tempCalorias = caloriasTotales;
                            proteinas = modProteina*double.parse(peso.text)*2.205;
                            tempCalorias -= (proteinas*4);
                            var calCarbs = ((porcentajeCarb/100.0) * tempCalorias);
                            tempCalorias -= calCarbs;
                            carbohidratos =   calCarbs/4;
                            grasas = tempCalorias/9;
                            print((porcentajeCarb/100.0));
                          } catch (e) {
                            //se genera una excepcion en caso de que faltara ingresar algun dato
                            Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Ingrese todos los datos", style: TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1, milliseconds: 500),
                                  ));
                          }
                          
                        });
                      },
                      child: new Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: new BoxDecoration(
                      color: Color(0xFF18D191),
                      borderRadius: new BorderRadius.circular(9.0)),
                      child: new Text("calcular",
                              style: new TextStyle(
                              fontSize: 15.0, color: Colors.white))),
                    ),
                  ),)
              ],
            ),
            new SizedBox(
              height: 15.0,
            ),
            
            
           Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            height: MediaQuery.of(context).size.height * 0.30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: items.length, itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Card(
                      color: Color(0xFFD218C2),
                      child: Container(
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 25.0,
                          ),
                          Align(
                                alignment: Alignment.centerLeft,
                                child: Container(padding:
                                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0), child: Center(child:Text(items[index].nombre, style: TextStyle(color: Colors.white, fontSize: 28.0)) ,) ,),
                          ),
                          
                          SizedBox(
                            height: 40.0,
                          ),
                          Text(items[index].numero.round().toString(), style: TextStyle(color: Colors.white, fontSize:35.0)),
                          ])
                      ),
                    ),
              );}),),
          ],
        ),
      ),
    ));
  }
}

class ItemInfo{
  String nombre;
  double numero;
  ItemInfo(this.nombre, this.numero);
}//contiene la informacion de los resultados que se van a mostrar