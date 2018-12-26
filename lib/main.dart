import 'dart:convert';
import 'package:careers/pages/PokeDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:careers/model/pokemons.dart';

void main() => runApp(MaterialApp(
  //---------------------------------------
  //      CONFIGURACION DE LA APP
  //---------------------------------------
      title: "Pokedex App",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/pokemongo-pokedex/master/pokedex.json";
  PokeHub pokeHub;

  @override
  void initState() {
    //ESTADO INICIAL DEL WIDGET
    super.initState();

    fetchData();
  }

  fetchData() async {
    //---------------------------------------
    //  Obtiene todos los datos de la API
    //---------------------------------------
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);

    pokeHub = PokeHub.fromJson(decodedJson);

    setState(
      //---------------------------------------
      //  Actualiza los datos al iniciar la app
      //---------------------------------------
        () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //---------------------------------------
      //         BARRA DE MENU
      //---------------------------------------
      appBar: AppBar(
        title: Text("Pokedex"),
        backgroundColor: Colors.cyan,
      ),

      //---------------------------------------
      //          CUERPO DEL SCAFFOLD
      //---------------------------------------
      body: pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2, //numero de columnas

              //LISTA DE TODOS LOS ELEMENTOS DEL JSON
              children: pokeHub.pokemon
                  .map((poke) => Padding(
                        padding:
                            const EdgeInsets.all(2.0), //agrega un espaciado
                        //FORMATO DE CADA CARTA
                        child: InkWell(
                          //Agrega la funcionalidad de clickable
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokeDetail(
                                          pokemon: poke,
                                        )));
                          },
                          child: Hero( //Agrega una animacion
                            tag: poke.img, //identificador
                            child: Card(
                              elevation: 3.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    //Crea una imagen
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(poke.img))),
                                  ),
                                  Text( //Nombre
                                    poke.name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),

      //---------------------------------------
      //MENU DESPLEGABLE
      //---------------------------------------
      drawer: Drawer(),


      //---------------------------------------
      // BOTON FLOTANTE
      //---------------------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
