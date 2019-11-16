import 'dart:async';

import 'package:http/http.dart' as http;


class LoripsumBloc{

  static String lorim;

  final _streamController = new StreamController<String>();
  get stream => _streamController.stream;

  fetch() async{
    try {
      var texto = lorim ?? await LoripsumApi.getLoripsum();
      lorim = texto;
      _streamController.add(texto);
    }catch(e){
      _streamController.addError(e);
    }
  }

  void dispose(){
    _streamController.close();
  }
}
class LoripsumApi{

   static Future<String> getLoripsum() async{

     var url = "https://loripsum.net/api";
     var response = await http.get(url);
     var text = response.body;

     text = text.replaceAll("<p>","");
     text = text.replaceAll("</p>","");

     return text;
   }
}