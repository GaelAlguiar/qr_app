import 'package:qr_app/database/usuarios.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB
{
  static Future<Database> _openDB() async
  {
    return openDatabase(join(await getDatabasesPath(), 'qrapp.db'),
    onCreate: (db,version)
    {
      return db.execute(
        "CREATE TABLE usuarios (id INTEGER PRIMARY KEY, nombre TEXT, matricula text, password text, email text)"
      );
    }, version: 1);
  }

  static Future<Future<int>> insert(Usuario usuario) async
  {
    Database database = await _openDB();
    return database.insert("usuarios", usuario.toMap());
  }
}