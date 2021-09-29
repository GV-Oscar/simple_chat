import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarios = [
    Usuario(online: true, email: 'test1@test.co', nombre: 'Oscar', uid: '1'),
    Usuario(
        online: false, email: 'test2@test.co', nombre: 'Angelica', uid: '2'),
    Usuario(online: true, email: 'test3@test.co', nombre: 'Melissa', uid: '3'),
    Usuario(online: true, email: 'test4@test.co', nombre: 'Lorena', uid: '4'),
    Usuario(online: true, email: 'test5@test.co', nombre: 'Paula', uid: '5'),
    Usuario(online: false, email: 'test6@test.co', nombre: 'Angie', uid: '6'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi nombre',
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.exit_to_app, color: Colors.black54)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.offline_bolt, color: Colors.red),
            // Icon(Icons.check_circle, color: Colors.blue),
          )
        ],
      ),
      body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, i) => ListTile(
                title: Text(usuarios[i].nombre),
                leading: CircleAvatar(
                    child:
                        Text(usuarios[i].nombre.substring(0, 2).toUpperCase())),
                trailing: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color:
                          usuarios[i].online ? Colors.green[300] : Colors.red,
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
          separatorBuilder: (_, i) => Divider(),
          itemCount: usuarios.length),
    );
  }
}
