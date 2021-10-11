import 'package:chat/models/usuarios_response.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';


class UsuariosServices {
  /// Obtener listado de usuarios
  Future<List<Usuario>> getUsuarios() async {
    try {

      final uri = Uri.parse('${Environment.apiUrl}/users');
      final res = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': '${await AuthService.getToken()}'
      });

      // Mapear respuesta de la API.
      final usuariosResponse = usuariosResponseFromJson(res.body);
      return usuariosResponse.usuarios;

    } catch (e) {
      print('Ocurrio un error al obtener usuarios: $e');
      return [];
    }
  }
}
