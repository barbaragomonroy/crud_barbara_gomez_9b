import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crudflutter_barbaragomezmonroy/modelos/notas.dart';

class Operaciones {
  static Future<Database> _openDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'notas.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS notas(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descripcion TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertarNota(Nota nota) async {
    Database db = await _openDB();
    await db.insert(
      'notas',
      nota.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> actualizarNota(Nota nota) async {
    Database db = await _openDB();
    await db.update(
      'notas',
      nota.toMap(),
      where: 'id = ?',
      whereArgs: [nota.id],
    );
  }

  static Future<void> eliminarNota(int id) async {
    Database db = await _openDB();
    await db.delete(
      'notas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Nota>> obtenerNotas() async {
    Database db = await _openDB();
    final List<Map<String, dynamic>> notasMaps = await db.query('notas');

    return List.generate(notasMaps.length, (i) {
      return Nota(
        id: notasMaps[i]['id'],
        titulo: notasMaps[i]['titulo'],
        descripcion: notasMaps[i]['descripcion'],
      );
    });
  }
}