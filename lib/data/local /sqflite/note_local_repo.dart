import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/local%20repositories/note/INoteLocalRepo.dart';
import 'package:sqflite/sqflite.dart';

import '../../../helper/db_helper.dart';

class NoteLocalRepository implements INoteLocalRepository {
  late Database _database;

  @override
  Future<void> openDatabase() async {
    _database = await DBHelper.instance.database();
  }

  @override
  Future<int> create({required Note obj}) async {
    return await _database.insert(
      'notes',
      obj.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Note>> getAllNotes() async {
    final List<Map<String, dynamic>> maps = await _database.query('notes');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  @override
  Future<List<Note>> search({required String text}) {
    throw UnimplementedError();
  }

  @override
  Future<void> update({required Note obj}) async {
    await _database
        .update('notes', obj.toMap(), where: 'id = ?', whereArgs: [obj.key]);
  }

  @override
  Future<void> closeDatabase() async {
    _database.close();
  }

  @override
  Future<void> delete({required int id}) async{
    _database.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
