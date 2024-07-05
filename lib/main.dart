import 'package:flutter/material.dart';
import 'package:crudflutter_barbaragomezmonroy/paginas/pagina_lista.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaLista(),
    );
  }
}
