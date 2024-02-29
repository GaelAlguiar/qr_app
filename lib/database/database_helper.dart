import 'package:sqflite/sqflite.dart';

class DatabaseHelper{

  Database? _db;
  Database get db => _db!;

  Future<void> init() async{
    _db = await openDatabase('database.db', version: 1, onCreate: (db,version){
      db.execute('CREATE TABLE alumnos (id_alumno INTEGER PRIMARY KEY AUTOINCREMENT, nombre varchar(255) )');
    });
  }
}
