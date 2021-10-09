import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkSignin(context),
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 1.0,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Cargando...'),
              ],
            ),
          );
        },
      ),
    );
  }

  Future checkSignin(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final isSigned = await authService.isSigned();
    if (isSigned) {
      // TODO: conectar al socket server
      // Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => UsuariosPage(),
              transitionDuration: Duration(microseconds: 0)));
    } else {
      // Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginPage(),
              transitionDuration: Duration(microseconds: 0)));
    }
  }
}
