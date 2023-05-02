import 'dart:io';
import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/domain/repository/notes/INoteRepo.dart';
import '../../constant.dart';
import '../response/response.dart';

class NoteRepository implements INoteRepository{
  final HttpClient client = HttpClient();

  @override
  Future<void> create({required Note obj}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required int idObj}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> search({required String text}) {
    throw UnimplementedError();
  }

  @override
  StreamNoteEither syncronizeData({required String idAccount}) {
    throw UnimplementedError();
  }

  @override
  Future<void> update({required Note obj}) {
    throw UnimplementedError();
  }

  @override
  StreamNoteEither getAllNotes({required String idAccount}) async* {
    yield ResponseEither(error: null, object: null);
    throw UnimplementedError();
  }

}