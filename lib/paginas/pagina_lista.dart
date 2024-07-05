import 'package:crudflutter_barbaragomezmonroy/bd/operaciones.dart';
import 'package:crudflutter_barbaragomezmonroy/paginas/guardar_pagina.dart';
import 'package:flutter/material.dart';
import 'package:crudflutter_barbaragomezmonroy/modelos/notas.dart';


class PaginaLista extends StatefulWidget {
  @override
  _PaginaListaState createState() => _PaginaListaState();
}

class _PaginaListaState extends State<PaginaLista> {
  late Future<List<Nota>> _listaNotas;

  @override
  void initState() {
    super.initState();
    _actualizarListaNotas();
  }

  void _actualizarListaNotas() {
    setState(() {
      _listaNotas = Operaciones.obtenerNotas();
    });
  }

  void _eliminarNota(int id) async {
    await Operaciones.eliminarNota(id);
    _actualizarListaNotas();
  }

  void _editarNota(Nota nota) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GuardarPagina(nota: nota)),
    );
    _actualizarListaNotas();
  }

  void _agregarNota() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GuardarPagina()),
    );
    _actualizarListaNotas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Notas'),
      ),
      body: FutureBuilder<List<Nota>>(
        future: _listaNotas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay notas disponibles'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final nota = snapshot.data![index];
              return ListTile(
                title: Text(nota.titulo),
                subtitle: Text(nota.descripcion),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editarNota(nota),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _eliminarNota(nota.id!),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarNota,
        child: Icon(Icons.add),
      ),
    );
  }
}