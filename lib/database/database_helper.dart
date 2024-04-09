import 'package:sqflite/sqflite.dart';

//class DatabaseHelper{

//Database? _db;
// Database get db => _db!;

// Future<void> init() async{
// _db = await openDatabase('database.db', version: 1, onCreate: (db,version){
//   db.execute('CREATE TABLE alumnos (id_alumno INTEGER PRIMARY KEY AUTOINCREMENT, nombre varchar(255) )');
// });
// }
// }
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  final String tableUsuarios = 'usuarios';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('loginqr.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    //crea base de datos en dispositivo
    await db.execute('''
    CREATE TABLE $tableUsuarios(
      id INTEGER PRIMARY KEY,
      matricula INTEGER,
      nombre TEXT,
      contraseña TEXT,
      tipo_cuenta TEXT
      )
      ''');
  }

  Future<void> insert(Regsuarios user) async { //RegUsuarios - donde se insertaran los datos del usuario para registrarse
    final db = await instance.database;
    await db.insert(tableUsuarios, user.toMap());
  }

  // Metodo toMap - iria en donde se realizara el sign in/login
 // Map<String, dynamic> toMap() {
    //return {
      //'id': id,
      //'matricula': matricula,
      //'nombre': nombre,
      //'contraseña': contraseña,
    //};
  //}
}
