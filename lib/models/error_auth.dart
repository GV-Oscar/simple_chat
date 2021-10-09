import 'dart:convert';

ErrorAuth errorAuthFromJson(String str) => ErrorAuth.fromJson(json.decode(str));

String errorAuthToJson(ErrorAuth data) => json.encode(data.toJson());

/// Error de autenticacion
class ErrorAuth {
  ErrorAuth({
    required this.msg,
    required this.param,
    required this.location,
  });

  String msg;
  String param;
  String location;

  factory ErrorAuth.fromJson(Map<String, dynamic> json) => ErrorAuth(
        msg: json["msg"],
        param: json["param"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "param": param,
        "location": location,
      };
}
