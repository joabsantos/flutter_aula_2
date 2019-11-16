import 'dart:convert';
import 'package:carros/pages/favoritos/carro-dao.dart';
import 'package:carros/pages/login/usuario.dart';
import 'carro.dart';
import 'package:http/http.dart' as http;

class TipoCarro{
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

    var usuario = await Usuario.get();
    var headers = {
      "Content-Type": "application/json",
      "Authorization" : "Bearer ${usuario.token}"
    };

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';
    var response = await http.get(url, headers: headers);
    var list = json.decode(response.body);
    var carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();



    return carros;
  }
}
