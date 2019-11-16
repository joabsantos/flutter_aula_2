import 'dart:async';

import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

import 'carro.dart';
import 'carro_page.dart';
import 'carros_api.dart';
import 'carros_bloc.dart';
import 'carros_listview.dart';

class CarrosPage extends StatefulWidget {
  String tipo;

  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final _bloc = CarrosBloc();

  String get tipo => widget.tipo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.fetch(tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) TextError("Não foi possível buscar os carros");

        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        var carros = snapshot.data;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarroListView(carros),
        );
      },
    );
  }

Future<void> _onRefresh() => _bloc.fetch(tipo);

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }


}
