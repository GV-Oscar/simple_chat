import 'dart:convert';

import 'package:chat/models/usuario.dart';

SigninResponse signinResponseFromJson(String str) => SigninResponse.fromJson(json.decode(str));
String signinResponseToJson(SigninResponse data) => json.encode(data.toJson());

class SigninResponse {
  SigninResponse({
    required this.ok,
    required this.usuario,
    required this.token,
  });

  bool ok;
  Usuario usuario;
  String token;

  factory SigninResponse.fromJson(Map<String, dynamic> json) => SigninResponse(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
      };
}
