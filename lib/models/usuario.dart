class Usuario {
  bool online;
  String email;
  String nombre;
  String uid;
  String? phone;
  String? phonePrefix;

  Usuario(
      {required this.online,
      required this.email,
      required this.nombre,
      required this.uid,
      this.phone,
      this.phonePrefix});
}
