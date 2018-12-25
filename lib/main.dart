import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:careers/model/careers.dart';

void main() => runApp(MaterialApp(
  title: "Careers App",
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

  var url = "https://raw.githubusercontent.com/Biuni/pokemongo-pokedex/master/pokedex.json";
  PokeHub pokeHub;

  @override
  void initState(){
    //ESTADO INICIAL DEL WIDGET
    super.initState();

    fetchData();
  }

  fetchData() async{
    //Obtiene todos los datos de la API
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);


    pokeHub = PokeHub.fromJson(decodedJson);

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BARRA DE MENU
      appBar: AppBar(
        title: Text("Careers Info"),
        backgroundColor: Colors.cyan,
      ),


      //CUERPO DEL SCAFFOLD
      body: pokeHub == null? Center(
        child: CircularProgressIndicator(),
        )
        : GridView.count(
          crossAxisCount: 2, //numero de columnas
          
          //LISTA DE TODOS LOS ELEMENTOS DEL JSON
          children: pokeHub.pokemon.map((poke) => Padding(
            padding: const EdgeInsets.all(2.0), //agrega un espaciado
            //FORMATO DE CADA CARTA
            child: Card(
              elevation: 3.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container( //Crea una imagen
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(poke.img)
                      )
                    ),
                  ),

                  Text(
                    poke.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          )).toList(),
        ),


      //MENU DESPLEGABLE
      drawer: Drawer(),


      // BOTON FLOTANTE
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}