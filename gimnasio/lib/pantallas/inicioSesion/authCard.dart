import 'package:flutter/material.dart';
import '../../Usuario.dart';
import '../../drawer.dart' as drawer;
import 'package:http/http.dart' as http;
import 'dart:convert';
Usuario usuarioBD = null;
Acceso modo = Acceso();
enum AuthMode { Signup, Login }//si se inicia sesion o se crea usuario
class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}
Usuario usuario = Usuario();
class _AuthCardState extends State<AuthCard> {
  
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;//el modo actual
  Map<String, String> _authData = {
    'nombre': '',
    'email': '',
    'password': '',
  };//los datos que necesita el usuario
  var _isLoading = false; //para mostrar que se esta cargando una vez el usuario es verificado
  final _passwordController = TextEditingController();

  bool singUp(Usuario usuario, context){
    print("registrando");
    bool registrado = false;
    print("llamado");
    final Map<String, dynamic> data = {
                          'contrasenia':usuario.contrasenia,
                          'email': usuario.email,
                          'nombre': usuario.nombre,
                          'modo': "usuario",
                        };
    http.post("https://athlean-x-ba8ca.firebaseio.com/usuarios.json", body:  json.encode(data)).then((http.Response res){
      print("registrado");
       Navigator.push(context, MaterialPageRoute(
                             builder: (context) => drawer.Menu(),
                           ));
      setState(() {
        registrado = true;
      });
      
    });
    return registrado;
  }

  void logIn (String correo, String contrasenia, context) async{
    print("loging in...");
     await http
          .get('https://athlean-x-ba8ca.firebaseio.com/usuarios.json')
          .then((http.Response response) {
        var user = null;
        final Map<String, dynamic> listaDeMascotas = json.decode(response.body);
        listaDeMascotas.forEach((String userid, dynamic datosRespuesta) {
          if(datosRespuesta['email'] == correo && datosRespuesta['contrasenia'] == contrasenia){
            print("encontrado");
            user = Usuario(
              nombre: datosRespuesta['nombre'],
              email: datosRespuesta['email'],
              contrasenia: datosRespuesta['contrasenia'],
              modoAcceso: (datosRespuesta['modo'] == "admin")? ModoAcceso.Admin : ModoAcceso.Usuario,
              id: userid, );
              
          }
          
          print("logged");
        });
        usuarioBD = user; 
        
      });
      if(usuarioBD != null){
        modo.modo = usuarioBD.modoAcceso;
        modo.usuario = usuarioBD;
         Navigator.push(context, MaterialPageRoute(
                              builder: (context) => drawer.Menu(),
                           ));
      }else{
        Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Correo o contraseña invalido'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1, milliseconds: 500),
                                  ));
      }

  }

  Future<void> _submit() async {//se valida el usuario, se inicia sesion, o se registra el usuario, todavia falta 
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      logIn(_authData['email'], _passwordController.text, context);
      
    } else {
      usuario.email = _authData['email'];
      usuario.nombre = _authData['nombre'];
      usuario.contrasenia = _passwordController.text;
      singUp(usuario, context);
      
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {//para cambiar de modo
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;//el tamaño del dispositivo
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 375 : 260,//el tamaño del contenedor
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 375 : 260),//los limites
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                 if (_authMode == AuthMode.Signup)//se pide en caso de que se cree un usuario
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Nombre de usuario'),
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            _authData['nombre'] = value;
                          }
                        : null,
                  ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'correo invalido';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),//el correo siempre se va a pedir ya sea en registro o inicio de sesion
                TextFormField(
                  decoration: InputDecoration(labelText: 'contraseña'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'La contraseña es demasiado corta!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),//lo mismo para la contraseña
                if (_authMode == AuthMode.Signup)//solo si se esta iniciando sesion se piden estos datos
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'confirme contraseña'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Las contraseñas no coinciden!';
                            }
                          }
                        : null,
                  ),
                 
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  FlatButton(
                    color:  Color(0xFF18D191),
                    child:
                        Text(_authMode == AuthMode.Login ? 'Iniciar sesion' : 'Registrarse',),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'Registrarse' : 'Iniciar sesion'}', style:  TextStyle(color: Color(0xFF18D191)),),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}