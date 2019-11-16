import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

import 'carro/home_page.dart';
import 'favoritos/db-helper.dart';
import 'login/login_page.dart';
import 'login/usuario.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future futureA = DatabaseHelper.getInstance().db;
    Future futureB = Future.delayed(Duration(seconds: 3));
    var futureC = Usuario.get();


    Future.wait([futureA, futureB, futureC]).then((onValue) {
      var usuario = onValue[2];
      if (usuario != null)
        pushReplacement(context, HomePage());
      else
        pushReplacement(context, LoginPage());
    });
  }
}
