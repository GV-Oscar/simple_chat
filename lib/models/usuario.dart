import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    required this.name,
    required this.phone,
    required this.email,
    this.online = false,
    required this.uid,
  });

  String name;
  String phone;
  String email;
  bool online;
  String uid;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "online": online,
        "uid": uid,
      };
}
