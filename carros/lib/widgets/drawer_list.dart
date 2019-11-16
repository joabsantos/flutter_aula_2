import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {

   _header(Usuario usuario) {
    return UserAccountsDrawerHeader(
      accountName: Text(usuario.nome),
      accountEmail: Text(usuario.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(usuario.urlFoto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var future = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: future,
              builder: (context, snapshot) {
                var usuario = snapshot.data;
                return usuario != null ? _header(usuario) : Container();
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("Mias informações"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print('Item 1');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("Mias informações"),
              trailing: Icon(Icons.help),
              onTap: () {
                print('Item 1');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              subtitle: Text("Mais informações"),
              trailing: Icon(Icons.all_out),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
     Usuario.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
