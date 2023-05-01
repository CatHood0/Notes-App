// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../domain/entities/Note.dart';
import '../domain/entities/check.dart';

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

  Future<void> closeDb() async => _db!.close();
}

class NoteDao {
  late Database database;

  Future<void> openDb() async {
    database = await DBHelper.instance.database();
  }

  Future<int> insert(Note note) async {
    return await database.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(Note note) async {
    await database
        .update('notes', note.toMap(), 
        where: 'id = ?', 
        whereArgs: [note.key]);
  }

  Future<void> closeConnection() async => database.close();

  Future<List<Note>> getAllNotes() async {
    final List<Map<String, dynamic>> maps = await database.query('notes');
    return List.generate(maps.length, (i) {
      print(maps[i]['id']);
      return Note.fromMap(maps[i]);
    });
  }
}

class ChecklistDao {
  late Database database;

  Future<void> openDb() async {
    database = await DBHelper.instance.database();
  }

  Future<void> insert(Check checklist) async {
    await database.insert(
      'checklists',
      checklist.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Check>> getAllChecklists() async {
    final List<Map<String, dynamic>> maps = await database.query('checklists');
    return List.generate(maps.length, (i) {
      return Check(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
      );
    });
  }
}
