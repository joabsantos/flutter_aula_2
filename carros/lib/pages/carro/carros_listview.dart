import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

import 'carro.dart';
import 'carro_page.dart';


class CarroListView extends StatelessWidget {
  List<Carro> carros;

  CarroListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemBuilder: (context, index) {
          var carro = carros[index];

          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: carro.urlFoto ?? "http://via.placeholder.com/150",
                      width: 250,
                    ),
                  ),
                  Text(
                    carro.nome ?? 'Sem Nome',
                    style: TextStyle(fontSize: 25),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Descrição",
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonTheme.bar(
                    // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickCarro(context,carro),
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () {
                            /* ... */
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: carros != null ? carros.length : 0,
      ),
    );
  }

  _onClickCarro(context, Carro carro) {
    push(context, CarroPage(carro));
  }
}
