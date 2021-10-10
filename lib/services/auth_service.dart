import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';
import 'package:chat/models/signin_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  /// Usuario
  Usuario? _usuario;

  Usuario? get usuario => this._usuario;

  set usuario(Usuario? usuario) {
    this._usuario = usuario;
    notifyListeners();
  }

  /// Define si el usuario esta iniciando una peticion de autenticacion
  bool _isAuthenticating = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  /// Comprueba si se esta realizando una petición para ingresar;
  bool get isAuthenticating => this._isAuthenticating;

  /// Establecer estado de peticion de autenticacion.
  set isAuthenticating(bool value) {
    this._isAuthenticating = value;
    notifyListeners();
  }

  /// Obtener token de usuario
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final String? token = await _storage.read(key: 'token');
    return token;
  }

  /// Borrar token de usuario
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    return await _storage.delete(key: 'token');
  }

  /// Iniciar sesion.
  Future<bool> signin(String email, String password) async {
    // Establecer inicio de peticion de ingreso
    this.isAuthenticating = true;

    final payload = {'email': email, 'password': password};

    // Establecer punto final de la API de ingreso
    final url = Uri.parse('${Environment.apiUrl}/auth/signin');
    // Realizar llamada al API.
    final response = await http.post(url,
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'});

    // Establecer fin de peticion de ingreso
    this.isAuthenticating = false;

    // Resultado exitoso
    if (response.statusCode == 200) {
      final signinResponse = signinResponseFromJson(response.body);
      this.usuario = signinResponse.usuario!;

      // Guardar token en lugar seguro.
      await this._saveToken(signinResponse.token);

      return true;
    } else {
      return false;
    }
  }

  /// Registrar un nuevo usuario
  Future<dynamic> signup(
      String name, String phone, String email, String password) async {
    // Establecer inicio de peticion de registro
    this.isAuthenticating = true;

    final payload = {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    };

    // Establecer punto final de la API de registro
    final url = Uri.parse('${Environment.apiUrl}/auth/signup');
    // Realizar llamada al API de registro.
    final response = await http.post(url,
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'});

    // Establecer fin de peticion de registro
    this.isAuthenticating = false;

    // Resultado exitoso
    if (response.statusCode == 200) {
      final signinResponse = signinResponseFromJson(response.body);
      this.usuario = signinResponse.usuario!;

      // Guardar token en lugar seguro.
      await this._saveToken(signinResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(response.body);
      return respBody['msg'];
    }
  }

  /// Guardar token en almacenamiento seguro.
  Future<void> _saveToken(String? token) async {
    return await this._storage.write(key: 'token', value: token);
  }

  /// Cerrar sesion de usuario.
  Future<void> signout() async {
    return await this._storage.delete(key: 'token');
  }

  /// Comprobar si el usuario tiene un token valido
  Future<bool> isSigned() async {
    // Leer token
    final token = await this._storage.read(key: 'token');

    // Establecer punto final de la API de renovar token
    final url = Uri.parse('${Environment.apiUrl}/auth/renew');
    final response = await http.get(url,
        headers: {'Content-Type': 'application/json', 'x-token': '$token'});

    // Resultado exitoso
    if (response.statusCode == 200) {
      final signinResponse = signinResponseFromJson(response.body);
      this.usuario = signinResponse.usuario!;
      // Guardar token en lugar seguro.
      await this._saveToken(signinResponse.token);
      return true;
    } else {
      this.signout();
      return false;
    }
  }
}
