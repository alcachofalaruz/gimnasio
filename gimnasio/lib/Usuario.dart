enum ModoAcceso{Usuario, Admin}
class Usuario{
  Usuario({this.nombre, this.contrasenia, this.id, this.email, this.modoAcceso = ModoAcceso.Admin});
  String nombre,email;
  String contrasenia;
  String id;
  ModoAcceso modoAcceso;
}//clase molde de los usuarios

class Acceso {
  static final Acceso _singleton = Acceso._internal();
  ModoAcceso modo = ModoAcceso.Usuario;
  Usuario usuario;
  factory Acceso() {
    return _singleton;
  }

  Acceso._internal();
}