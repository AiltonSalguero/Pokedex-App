import 'package:flutter/material.dart';
import 'package:careers/model/careers.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail({this.pokemon});

  bodyWidget() => Stack(
        children: <Widget>[
          Container(
            child: Card(
              child: Column(
                children: <Widget>[
                  Text(pokemon.name),
                  Text("Height ${pokemon.height}"),
                  Text("Height ${pokemon.weight}"),
                  Text("Types"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((t) =>
                            FilterChip(label: Text(t), onSelected: (b) {}))
                        .toList(),
                  ),
                  Text("Weakness"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((t) =>
                            FilterChip(label: Text(t), onSelected: (b) {}))
                        .toList(),
                  ),
                  Text(
                    "Next Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.nextEvolution
                              ?.map((n) => FilterChip(
                                  backgroundColor: Colors.green,
                                  label: Text(
                                    n.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {}))
                              ?.toList() ??
                          [Text('No more evolutions')])
                ],
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,

      //Barra de menu
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text(pokemon.name),
      ),

      //Contenido del Scaffold
      body: bodyWidget(),
    );
  }
}
