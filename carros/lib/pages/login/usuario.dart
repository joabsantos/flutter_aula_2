import 'dart:convert';

import 'package:carros/utils/prefs.dart';

class Usuario {
   int id;
   String login;
   String nome;
   String email;
   String urlFoto;
   String token;
   List<String> roles;

   Usuario(
       {this.id,
          this.login,
          this.nome,
          this.email,
          this.urlFoto,
          this.token,
          this.roles});

   Usuario.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      login = json['login'];
      nome = json['nome'];
      email = json['email'];
      urlFoto = json['urlFoto'];
      token = json['token'];
      roles = json['roles'] != null ? json['roles'].cast<String>() : [];
   }

   Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['login'] = this.login;
      data['nome'] = this.nome;
      data['email'] = this.email;
      data['urlFoto'] = this.urlFoto;
      data['token'] = this.token;
      data['roles'] = this.roles;
      return data;
   }

   void save(){
      var map = toJson();
      var userJson = json.encode(map);
      Prefs.setString("user.prefs", userJson);
   }

   static Future<Usuario> get() async{
       var userJson = await Prefs.getString("user.prefs");

       if(userJson.isEmpty)
          return null;

       var map = json.decode(userJson);
       return Usuario.fromJson(map);
   }


   @override
   String toString() {
      return 'Usuario{id: $id, login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles}';
   }

  static void clear() {
     Prefs.setString("user.prefs", "");
  }
}