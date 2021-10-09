import 'dart:convert';

import 'package:chat/models/error_auth.dart';

ErrorsAuthResponse errorAuthResponseFromJson(String str) =>
    ErrorsAuthResponse.fromJson(json.decode(str));

String errorAuthResponseToJson(ErrorsAuthResponse data) =>
    json.encode(data.toJson());

class ErrorsAuthResponse {
  ErrorsAuthResponse({
    this.name,
    this.phone,
    this.email,
    this.password,
  });

  ErrorAuth? name;
  ErrorAuth? phone;
  ErrorAuth? email;
  ErrorAuth? password;

  factory ErrorsAuthResponse.fromJson(Map<String, dynamic> json) =>
      ErrorsAuthResponse(
        name: ErrorAuth.fromJson(json["name"]),
        phone: ErrorAuth.fromJson(json["phone"]),
        email: ErrorAuth.fromJson(json["email"]),
        password: ErrorAuth.fromJson(json["password"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name?.toJson(),
        "phone": phone?.toJson(),
        "email": email?.toJson(),
        "password": password?.toJson(),
      };
}
