import 'package:flutter/material.dart';
import 'package:crudflutter_barbaragomezmonroy/bd/operaciones.dart';
import 'package:crudflutter_barbaragomezmonroy/modelos/notas.dart';

class GuardarPagina extends StatefulWidget {
  final Nota? nota;

  GuardarPagina({this.nota});

  @override
  _GuardarPaginaState createState() => _GuardarPaginaState();
}

class _GuardarPaginaState extends State<GuardarPagina> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.nota != null) {
      _tituloController.text = widget.nota!.titulo;
      _descripcionController.text = widget.nota!.descripcion;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _guardarNota() async {
    if (_formKey.currentState?.validate() ?? false) {
      Nota nota = Nota(
        id: widget.nota?.id, // Solo se asigna si se está editando
        titulo: _tituloController.text,
        descripcion: _descripcionController.text,
      );

      if (widget.nota == null) {
        await Operaciones.insertarNota(nota);
      } else {
        await Operaciones.actualizarNota(nota);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nota == null ? 'Guardar Nota' : 'Editar Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  if (value.split(' ').length > 100) {
                    return 'La descripción no puede exceder las 100 palabras';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarNota,
                child: Text(widget.nota == null ? 'Guardar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}