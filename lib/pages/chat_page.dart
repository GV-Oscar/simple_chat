import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textCtrl = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _escribiendo = false;
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 16,
              child: Text(
                'OG',
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue[100],
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Oscar Giraldo',
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    itemCount: _messages.length,
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    itemBuilder: (_, i) => _messages[i])),

            Divider(height: 1),

            // TODO: Caja de texto
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textCtrl,
            onSubmitted: _handleSubmit,
            onChanged: (String texto) {
              // TODO: cuando hay un valor, para postear.
              setState(() {
                if (texto.trim().length > 0) {
                  _escribiendo = true;
                } else {
                  _escribiendo = false;
                }
              });
            },
            decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            focusNode: _focusNode,
          )),

          // Boton de enviar
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _escribiendo
                          ? () => _handleSubmit(_textCtrl.text.trim())
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            tooltip: 'Enviar mensaje',
                            onPressed: _escribiendo
                                ? () => _handleSubmit(_textCtrl.text.trim())
                                : null,
                            icon: Icon(
                              Icons.send,
                            )),
                      ),
                    ))
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    print(texto);
    if (texto.trim().length == 0) return;

    this._textCtrl.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '123',
      texto: texto,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );

    this._messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _escribiendo = false;
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose

    // Cancelar escucha del socket

    // limpiar animaciones de cada mensaje
    for(ChatMessage message in this._messages){
      message.animationController.dispose();
    }

    super.dispose();
  }
}
