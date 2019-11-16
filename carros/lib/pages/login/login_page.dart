import 'dart:async';

import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

import 'package:carros/pages/login/login_api.dart';

import 'package:carros/pages/carro/home_page.dart';

import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  final _tLogin = new TextEditingController();
  final _tSenha = new TextEditingController();
  final _focusSenha = FocusNode();
  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose(){
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite seu login",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(
              height: 10,
            ),
            AppText("Senha", "Digite sua senha",
                password: true,
                controller: _tSenha,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                focusNode: _focusSenha),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
              stream: _bloc.stream,
              builder: (context, snapshot) {
                return AppButton(
                  "Login",
                  onPressed: _onClickLogin,
                  showProgress: snapshot.data ?? false,
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    var formOk = _formKey.currentState.validate();
    if (!formOk) {
      return;
    }

    var senha = _tSenha.text;
    var login = _tLogin.text;

    print("Login: $login, senha: $senha");

    var response = await _bloc.login(login, senha);
    if (response.ok) {
      var usuario = response.result;
      print(usuario);
      push(context, HomePage(), replace: true);
    } else
      alert(context, response.msg);
  }

  String _validateLogin(String text) {
    if (text.isEmpty) return "Digite o Login";
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) return "Digite a Senha";
    if (text.length < 3) return "Senha muito curta";
    return null;
  }
}
