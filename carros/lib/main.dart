import 'package:carros/pages/login/login_page.dart';
import 'package:flutter/material.dart';

import 'pages/SplashPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white
      ),
      home:SplashPage(),
    );
  }
}