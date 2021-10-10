import 'package:flutter/material.dart';


import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(
        online: true,
        phone: '+573188632311',
        email: 'test1@test.co',
        name: 'Oscar',
        uid: '1'),
    Usuario(
        online: false,
        phone: '+573188632312',
        email: 'test2@test.co',
        name: 'Angelica',
        uid: '2'),
    Usuario(
        online: true,
        phone: '+573188632313',
        email: 'test3@test.co',
        name: 'Melissa',
        uid: '3'),
    Usuario(
        online: true,
        phone: '+573188632314',
        email: 'test4@test.co',
        name: 'Lorena',
        uid: '4'),
    Usuario(
        online: true,
        phone: '+573188632315',
        email: 'test5@test.co',
        name: 'Paula',
        uid: '5'),
    Usuario(
        online: false,
        phone: '+573188632316',
        email: 'test6@test.co',
        name: 'Angie',
        uid: '6'),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final user = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${user?.name}',
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              socketService.disconnect();
              AuthService.deleteToken();
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: Icon(Icons.exit_to_app, color: Colors.black54)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.offline_bolt, color: Colors.red),
            // Icon(Icons.check_circle, color: Colors.blue),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
            complete: Icon(Icons.check_circle_outline_outlined,
                color: Colors.blue[400]),
            waterDropColor: Colors.blue),
        child: _usuariosListView(),
      ),
    );
  }

  ListView _usuariosListView() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.name),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.name.substring(0, 2).toUpperCase()),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  void _cargarUsuarios() async {
    // TODO: Traer info del Endpoint

    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
