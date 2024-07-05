class Nota {
  final int? id;
  final String titulo;
  final String descripcion;

  Nota({this.id, required this.titulo, required this.descripcion});

  Map<String, dynamic> toMap() {
    final map = {
      'titulo': titulo,
      'descripcion': descripcion,
    };

    if (id != null) {
    }

    return map;
  }

  factory Nota.fromMap(Map<String, dynamic> map) {
    return Nota(
      id: map['id'] as int?, // Asegúrate de que el tipo de datos sea correcto
      titulo: map['titulo'] as String,
      descripcion: map['descripcion'] as String,
    );
  }
}