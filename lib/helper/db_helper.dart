import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();

  static Database? _db;

  DBHelper._internal();

  Future<Database> database() async {
    if (_db != null) return _db!;

    _db = await _initDB('notes_app.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _updateDatabase,
      singleInstance: true,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            id_folder INTEGER,
            id_user INTEGER,
            title TEXT NOT NULL, 
            content TEXT NOT NULL, 
            create_date VARCHAR (100) NOT NULL, 
            modification_date VARCHAR (100) NOT NULL, 
            favorite BOOLEAN NOT NULL, 
            last_position REAL NOT NULL, 
            password VARCHAR (10))''',
    );
    await db.execute(
      '''CREATE TABLE checklists(
          id INTEGER PRIMARY KEY, 
          id_user INTEGER,
          name TEXT, 
          content TEXT, 
          create_date VARCHAR (100) NOT NULL, 
          modification_date VARCHAR (100) NOT NULL, 
          complete BOOLEAN NOT NULL
        
        )''',
    );
    await db.execute(
      '''CREATE TABLE folders(
          id INTEGER PRIMARY KEY, 
          name TEXT NOT NULL, 
          description TEXT, 
          create_date VARCHAR (100) NOT NULL, 
          pinned BOOLEAN NOT NULL)''',
    );

    await db.execute('''CREATE TABLE task(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          id_user INTEGER,
          creation_date VARCHAR (255) NOT NULL,
          detail VARCHAR (255) NOT NULL,
          finish_it VARCHAR (255) NOT NULL''');

    //Share (only can use if the user is logged)
    await db.execute('''
        CREATE TABLE share(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          id_user_receive INTEGER NOT NULL,
          id_user_send INTEGER NOT NULL,
          message VARCHAR (255) NOT NULL),''');

    //tables for references
    await db.execute('''
        CREATE TABLE share_notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          id_share INTEGER NOT NULL,
          id_note INTEGER NOT NULL,
          FOREIGN KEY (id_share) REFERENCES share(id),
          FOREIGN KEY (id_note) REFERENCES note(id))
                                                    ''');

    await db.execute('''
        CREATE TABLE folder_notes(
          id PRIMARY KEY AUTOINCREMENT,
          id_folder INTEGER NOT NULL,
          id_note INTEGER NOT NULL,
          FOREIGN KEY (id_folder) REFERENCES folder(id),
          FOREIGN KEY (id_note) REFERENCES note(id))
                                                      ''');
  }

  Future<void> _updateDatabase(
      Database db, int oldVersion, int newVersion) async {
    //notes
    await db.execute(
        'ALTER TABLE notes ADD COLUMN last_position REAL NOT NULL DEFAULT 0.0;');
    await db.execute('ALTER TABLE notes ADD COLUMN password VARCHAR (10)');
    await db.execute('ALTER TABLE notes ADD COLUMN id_folder INTEGER');
    await db.execute('ALTER TABLE notes ADD COLUMN id_user INTEGER');

    //checklist
    await db.execute(
        'ALTER TABLE checklists ADD COLUMN content TEXT NOT NULL DEFAULT "";');
    await db.execute(
        'ALTER TABLE checklists ADD COLUMN create_date VARCHAR (100) NOT NULL DEFAULT "";');
    await db.execute(
        'ALTER TABLE checklists ADD COLUMN modification_date VARCHAR (100) NOT NULL DEFAULT "";');
    await db.execute(
        'ALTER TABLE checklists ADD COLUMN complete BOOLEAN NOT NULL DEFAULT 0;');

    //folders
    await db
        .execute('ALTER TABLE folders ADD COLUMN description TEXT DEFAULT "";');
    await db.execute(
        'ALTER TABLE folders ADD COLUMN create_date VARCHAR (100) NOT NULL DEFAULT "";');
    await db.execute(
        'ALTER TABLE folders ADD COLUMN pinned BOOLEAN NOT NULL DEFAULT 0;');
  }

  Future<void> printTables(Database db) async {
  final tables = await db.query(
    'sqlite_master',
    where: 'type = ?',
    whereArgs: ['table'],
    columns: ['name'],
  );
  for (final table in tables) {
    print(table['name']);
  }
}


  Future<void> closeDatabase() async => _db!.close();
}
