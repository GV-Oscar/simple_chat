import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/models/signin_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {

  Usuario? usuario;

  /// Iniciar sesión
  Future signin(String email, String password) async {
    
    final data = {
      'email': email,
      'password': password
    };

    final urlApi = Uri.parse('${Environment.apiUrl}/auth/signin');
    final response = await http.post(urlApi,
    body: jsonEncode(data),
    headers: {
      'Content-Type':'application/json'
    });

    print(response.body);
    if (response.statusCode == 200) {
      final signinResponse = signinResponseFromJson(response.body);
      this.usuario = signinResponse.usuario;
    }
  }

}