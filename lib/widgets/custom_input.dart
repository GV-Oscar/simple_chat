import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// TextField personalizado
class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isShowInfo;
  //void Function()? onPressedInfo;

  final String titleDialogInfo;
  final String subtitleDialogInfo;
  final bool isDismissibleDialogInfo;
  final bool isShowCanceledActionDialogInfo;
  final bool isShowAcceptedActionDialogInfo;
  void Function()? onCanceledDialogInfo;
  void Function()? onAcceptedDialogInfo;
  final String? textCanceledDialogInfo;
  final String? textAcceptedDialogInfo;

  CustomInput({
    Key? key,
    required this.icon,
    required this.placeholder,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isShowInfo = false,
    // this.onPressedInfo,
    // this.changeObscureText,
    required this.titleDialogInfo,
    required this.subtitleDialogInfo,
    this.isDismissibleDialogInfo = true,
    this.isShowCanceledActionDialogInfo = false,
    this.textCanceledDialogInfo = 'Cancelar',
    this.onCanceledDialogInfo,
    this.isShowAcceptedActionDialogInfo = false,
    this.textAcceptedDialogInfo = 'Aceptar',
    this.onAcceptedDialogInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 5, left: 5, bottom: 5, right: (isShowInfo) ? 5 : 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        controller: textController,
        textAlignVertical: TextAlignVertical.center,
        autocorrect: false,
        keyboardType: keyboardType,
        // obscureText: changeObscureText!.call(),
        obscureText: isPassword,
        decoration: InputDecoration(
            suffixIcon: _checkInfo(context),
            //suffixText: placeholder,
            prefixIcon: Icon(icon),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: placeholder),
      ),
    );
  }

  _checkInfo(BuildContext context) {
    if (this.isShowInfo) {
      return GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onTap: ()=> _showCustomDialog(context),
        child: Icon(Icons.info_outline),
      );
    }
    return null;
  }

  _showCustomDialog(BuildContext context) {
    if (Platform.isAndroid) {
      return _showDialogAndroid(context);
    }
    if (Platform.isIOS) {
      return _showDialogIOS(context);
    }
  }

  _showDialogAndroid(BuildContext context) {
    showDialog(
        context: context,
        // Indica que el dialogo solo se cierra con las acciones.
        barrierDismissible: this.isDismissibleDialogInfo,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('${this.titleDialogInfo}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('${this.subtitleDialogInfo}'),
              ],
            ),
            actions: <Widget>[_getActionCanceled(), _getActionAccepted()],
            //actionsAlignment: MainAxisAlignment.spaceBetween,
            actionsPadding: EdgeInsets.symmetric(horizontal: 10),
          );
        });
  }

  _showDialogIOS(BuildContext context) {
    showCupertinoDialog(
        context: context,
        // Indica que el dialogo solo se cierra con las acciones.
        barrierDismissible: this.isDismissibleDialogInfo,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('${this.titleDialogInfo}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('${this.subtitleDialogInfo}'),
              ],
            ),
            actions: <Widget>[_getActionCanceled(), _getActionAccepted()],
          );
        });
  }

  Widget _getActionCanceled() {
    if (isShowCanceledActionDialogInfo) {
      return Container(
        margin: EdgeInsets.only(right: 10),
        child: OutlinedButton(
            onPressed: onCanceledDialogInfo, child: Text('${this.textCanceledDialogInfo}')),
      );
    }
    return Container();
  }

  Widget _getActionAccepted() {
    if (isShowAcceptedActionDialogInfo) {
      return Container(
        margin: EdgeInsets.only(left: 10),
        child: ElevatedButton(
            onPressed: onAcceptedDialogInfo, child: Text('${this.textAcceptedDialogInfo}')),
      );
    }
    return Container();
  }
}

