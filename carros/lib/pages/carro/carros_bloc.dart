import 'dart:async';

import 'package:carros/pages/favoritos/carro-dao.dart';
import 'package:carros/utils/network.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarrosBloc{
  final _streamController = new StreamController<List<Carro>>();
  get stream => _streamController.stream;

  Future<void> fetch(String tipo) async{
    try {

      bool networkOn = await isNetworkOn();
      if(! networkOn){
        var carros = await CarroDAO().findAllByTipo(tipo);
        _streamController.add(carros);
        return;
      }

      var carros = await CarrosApi.getCarros(tipo);
      _streamController.add(carros);

      final dao = CarroDAO();
      for(var carro in carros)
        dao.save(carro);

    }catch(e){
      _streamController.addError(e);
    }
  }

  void dispose(){
    _streamController.close();
  }
}