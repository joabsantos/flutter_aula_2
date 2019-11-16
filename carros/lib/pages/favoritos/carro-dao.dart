import 'dart:async';


import 'package:carros/pages/carro/carro.dart';
import 'package:sqflite/sqflite.dart';

import 'base_dao.dart';
import 'db-helper.dart';

// Data Access Object
class CarroDAO extends BaseDAO<Carro> {
  @override
  // TODO: implement tableName
  String get tableName => null;

  @override
  Carro fromMap(Map<String, dynamic > map) {
    // TODO: implement fromJson
    return Carro.fromMap(map);
  }


  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from $tableName where tipo =? ',[tipo]);

    return list.map<Carro>((json) => fromMap(json)).toList();
  }
}
