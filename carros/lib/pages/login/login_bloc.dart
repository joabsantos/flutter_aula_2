import 'dart:async';

import 'package:carros/pages/login/usuario.dart';

import '../ApiResponse.dart';
import 'login_api.dart';

class LoginBloc {
  final _streamControler = StreamController<bool>();

  get stream => _streamControler.stream;

  Future<ApiResponse<Usuario>> login(String login, String senha) async {

    _streamControler.add(true);

     var response = await LoginApi.login(login, senha);

    _streamControler.add(false);

    return response;
  }

  void dispose() => _streamControler.close();
}
