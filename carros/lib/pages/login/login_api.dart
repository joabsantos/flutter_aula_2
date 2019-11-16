import 'dart:convert';

import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

import '../ApiResponse.dart';



class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

      final params = {
        'username': login,
        'password': senha
      };

      var headers = {
        "Content-Type": "application/json"
      };

      var s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var mapRsponse = json.decode(response.body);

      if (response.statusCode == 200) {
        var usuario = new Usuario.fromJson(mapRsponse);
        usuario.save();
        return ApiResponse.ok(usuario);
      }

      return ApiResponse.error(mapRsponse["error"]);
    } catch (error, exception) {
      print("Erro no login $error > $exception");
      return ApiResponse.error("Não foi possível fazer login");
    }
  }
}
