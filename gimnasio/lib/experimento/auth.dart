import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Auth with ChangeNotifier{
  String _token;
  DateTime _expiryDate;
  String _userId;
  Future<void> signup(String email, String password) async{
    print("aca");
    const String url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyA60YyGsrzV-uZe8tgvcmFZMpNlnet2wTU';
    final response = await http.post(url, body:json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true
    }));
    print(json.decode(response.body));
  }
  
}