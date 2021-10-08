import 'package:chat/helpers/show_alert.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/custom_submit_button.dart';
import 'package:chat/widgets/labels.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/logo.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(
                    assetName: 'assets/tag-logo.png',
                    isSubtitle: true,
                    subtitle: 'Messenger'),
                _Form(),
                Labels(
                  textLabel1: '¿No tienes cuenta?',
                  textLabel2: 'Crea una ahora!',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'register');
                  },
                ),
                _Legal(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
            isShowInfo: true,
            titleDialogInfo: 'Tu correo electrónico',
            subtitleDialogInfo:
                'Introduzca el correo electrónico que utilizó para registrarse',
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            isPassword: true,
            textController: passCtrl,
            isShowInfo: true,
            titleDialogInfo: 'Tu contraseña',
            subtitleDialogInfo:
                'Introduzca la contraseña que utilizó para registrarse',
          ),

          CustomSubmitButton(
            text: 'Ingresar',
            onPressed: authService.isSignin
                ? null
                : () async {
                    // Esconder teclado.
                    FocusScope.of(context).unfocus();
                    
                    // Ejecutar servicio para iniciar sesion
                    final resultOK = await authService.signin(emailCtrl.text.trim(), passCtrl.text);

                    if(resultOK){
                      // TODO: Conectar a nuestro socket server

                      // TODO: Navegar a otra pantalla
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    }else{
                      // Mostrar alerta
                      showAlert(context, 'Credenciales incorrectas', 'Revise su correo y contraseña nuevamente');
                    }
                  },
          )

          // TODO: Crear boton
        ],
      ),
    );
  }
}

class _Legal extends StatelessWidget {
  const _Legal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(bottom: 16),
      child: TextButton(
          onPressed: () {},
          child: Column(
            children: [
              Text(
                'Términos y condiciones de uso',
                style: TextStyle(fontWeight: FontWeight.w200),
              )
            ],
          )),
    );
  }
}
