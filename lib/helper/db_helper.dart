import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();

  static Database? _db;

  DBHelper._init();

  Future<Database> database() async {
    if (_db != null) return _db!;

    _db = await _initDB('notes_app.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, 
            title TEXT NOT NULL, content TEXT NOT NULL, create_date DATE NOT NULL, modification_date DATE NOT NULL, 
            favorite BOOLEAN NOT NULL, updates INTEGER NOT NULL, create_locally BOOLEAN NOT NULL, tag TEXT)''',
    );
    await db.execute(
      'CREATE TABLE checklists(id INTEGER PRIMARY KEY, name TEXT, description TEXT)',
    );
    await db.execute(
      'CREATE TABLE folders(id INTEGER PRIMARY KEY, name TEXT, color INTEGER)',
    );
  }

  Future<void> _updateDatabase(Database db, int version) async {
    await db.execute(
      '''
      Alter notes
      ''',
    );
  }

  Future<void> closeDatabase() async => _db!.close();
}
