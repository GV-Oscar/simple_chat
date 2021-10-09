import 'dart:convert';

import 'package:chat/models/errors_auth_response.dart';
import 'package:chat/models/usuario.dart';

SigninResponse signinResponseFromJson(String str) =>
    SigninResponse.fromJson(json.decode(str));
String signinResponseToJson(SigninResponse data) => json.encode(data.toJson());

class SigninResponse {
  SigninResponse({required this.ok, this.usuario, this.token, this.errors});

  bool ok;
  Usuario? usuario;
  String? token;
  ErrorsAuthResponse? errors;

  factory SigninResponse.fromJson(Map<String, dynamic> json) => SigninResponse(
      ok: json["ok"],
      usuario: json.containsKey('usuario') ? Usuario.fromJson(json['usuario']) : null,
      token:   json.containsKey('token') ? json['token'] : null,
      errors:  json.containsKey('errors') ? ErrorsAuthResponse.fromJson(json['errors']) : null);

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario?.toJson(),
        "token": token,
        'errors': errors?.toJson()
      };
}
