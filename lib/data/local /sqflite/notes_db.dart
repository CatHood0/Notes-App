import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/local%20repositories/INoteLocalRepo.dart';

class NoteLocalRepository implements INoteLocalRepository {
  @override
  Future<void> openDatabase() {
    // TODO: implement openDatabase
    throw UnimplementedError();
  }

  @override
  Future<void> create({required Note obj}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String idObj}) {
    throw UnimplementedError();
  }

  @override
  StreamNoteEither getAllNotes() {
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> search({required String text}) {
    throw UnimplementedError();
  }

  @override
  Future<void> update({required Note obj}) {
    throw UnimplementedError();
  }
}
