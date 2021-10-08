import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/models/signin_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {

  Usuario? usuario;
  bool _isSignin = false;

  /// Comprueba si se esta realizando una petición para ingresar;
  bool get isSignin => this._isSignin;
  set isSignin(bool value) {
    this._isSignin = value;
    notifyListeners();
  }

  /// Iniciar sesión
  Future<bool> signin(String email, String password) async {
    this.isSignin = true;

    final data = {'email': email, 'password': password};

    final url = Uri.parse('${Environment.apiUrl}/auth/signin');

    final response = await http.post(url,
    body: jsonEncode(data), 
    headers: {'Content-Type': 'application/json'});

    print(response.body);
    this.isSignin = false;

    if (response.statusCode == 200) {
      final signinResponse = signinResponseFromJson(response.body);
      this.usuario = signinResponse.usuario;

      // TODO: Guardar token en lugar seguro.
      
      return true;
    } else {
      return false;
    }
  }
}
