// Principal
import 'package:flutter/material.dart';
import 'package:usuarios_app/efectos/CargaCircular.dart';
import 'package:usuarios_app/paginas/GenerarTicket.dart';
import 'package:usuarios_app/paginas/Localizacion.dart';
import 'package:usuarios_app/usuarios/Usuarios.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        accentColor: Colors.tealAccent,
      ),
      home: new Inicio(),
    );
  }
}

class Inicio extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    List<Color> colores = [
      Colors.red,
      Colors.green,
      Colors.indigo,
      Colors.pinkAccent,
      Colors.blue
    ];
    return new Scaffold(
      body: Container(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Divider(
                height: 50.0,
                color: Colors.white,
              ),
              CargaCircular(colors: colores, duration: Duration(milliseconds: 1200)),
              Divider(
                height: 20.0,
                color: Colors.white,
              ),
            ]),
      ),
      appBar: new AppBar(
        title: new Text("ESupport"),
        // Búsqueda
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Rubén Verduzco López"),
              accountEmail: new Text("rube11_7@hotmail.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.pinkAccent,
                child: new Text("R"),
              ),
            ),
            // Barra de botones
            new ListTile(
              title: new Text("Inicio"),
              trailing: new Icon(Icons.home),
              // Por definir
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            // *********************************************************
            // Agregar página para usuarios. new Peopleworld()
            new Divider(),
            new ListTile(
                title: new Text("Usuarios"),
                trailing: new Icon(Icons.description),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context)=>
                      new Peopleworld()));
                }
            ),
            new Divider(),
            new ListTile(
                title: new Text("Generar Ticket"),
                trailing: new Icon(Icons.description),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context)=>
                      new GenerarTicket("Ya sirve")));
                }
            ),
            new Divider(),
            new ListTile(
              title: new Text("Localización"),
              trailing: new Icon(Icons.location_on),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context)=>
                      new Localizacion("Pronto se muestra")));
                }// Icono de localización
            ),
            new Divider(),
            new ListTile(
              title: new Text("Salir"),
              trailing: new Icon(Icons.exit_to_app),
              // Por definir
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String>{
  final busqueda=[
    "Hola",
    "Adiós"
  ];

  final busquedasRecientes=[
    "Hola"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de Appbar
    return [IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query="";
        })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //  Busca precionando el botón de la lupa
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation
        ),
        onPressed: () {
          close(context,null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Muestra algunos resultados basados en la búsqueda
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Se muestra cuando se encuentra algo
    final sugerencias=query.isEmpty
        ?busquedasRecientes
        :busqueda.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context,index)=>ListTile(
        onTap: (){
          showResults(context);
        },
        leading: Icon(Icons.search),
        title: RichText(
            text: TextSpan(
                text: sugerencias[index].substring(0,query.length),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: sugerencias[index].substring(query.length),
                      style: TextStyle(color: Colors.grey)
                  )]
            )
        ),
      ),
      itemCount: sugerencias.length,
    );
  }

}
