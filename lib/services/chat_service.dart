import 'package:chat/global/environment.dart';
import 'package:chat/models/mensaje.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late Usuario usuarioReceptor;

  /// Obtener chat de usuario
  Future<List<Mensaje>> getChat(String userID) async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/messages/$userID');
      final res = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': '${await AuthService.getToken()}'
      });

      // Mapear respues de API
      final messagesRes = mensajesResponseFromJson(res.body);
      // Devolver mensajes
      return messagesRes.mensajes;
    } catch (e) {
      print('Ocurrio un error al obtener mensajes de usuario: $e');
      return [];
    }
  }
}
