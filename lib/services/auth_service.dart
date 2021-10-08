import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';
import 'package:chat/models/signin_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _isSignin = false;
  // Create storage
  final _storage = new FlutterSecureStorage();

  /// Comprueba si se esta realizando una petición para ingresar;
  bool get isSignin => this._isSignin;
  set isSignin(bool value) {
    this._isSignin = value;
    notifyListeners();
  }

  // Getters del token de forma estatica
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final String? token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    return await _storage.delete(key: 'token');
  }

  /// Iniciar sesión
  Future<bool> signin(String email, String password) async {
    this.isSignin = true;

    final data = {'email': email, 'password': password};

    final url = Uri.parse('${Environment.apiUrl}/auth/signin');

    final response = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(response.body);
    this.isSignin = false;

    if (response.statusCode == 200) {
      final signinResponse = signinResponseFromJson(response.body);
      this.usuario = signinResponse.usuario;

      // Guardar token en lugar seguro.
      await this._saveToken(signinResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    return await this._storage.write(key: 'token', value: token);
  }

  /// Cerrar sesion de usuario.
  Future<void> _signout() async {
    return await this._storage.delete(key: 'token');
  }
}
