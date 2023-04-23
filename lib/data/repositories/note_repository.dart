import 'dart:io';

import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/domain/repository/notes/INoteRepo.dart';

class NoteRepository implements INoteRepository{
  final HttpClient client = HttpClient();

  @override
  Future<void> create({required note obj}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String idObj}) {
    throw UnimplementedError();
  }

  @override
  Stream<List<note>> getAllNotes({required String idAccount}) {
    throw UnimplementedError();
  }

  @override
  Future<List<note>> search({required String text}) {
    throw UnimplementedError();
  }

  @override
  Stream<List<note>> syncronizeData({required String idAccount}) {
    throw UnimplementedError();
  }

  @override
  Future<void> update({required note obj}) {
    throw UnimplementedError();
  }

}