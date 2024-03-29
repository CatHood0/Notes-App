import 'package:flutter_test/flutter_test.dart';
import 'package:notes_project/data/local%20/sqflite/note_local_repo.dart';
import 'package:notes_project/data/repositories/note_repository.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/domain/entities/Note.dart';

void main() {
  final NoteBloc bloc = NoteBloc(NoteRepository(), NoteLocalRepository());
  bloc.eventSink.add(AddNote(
      note: Note(
          title: "Hello",
          content: '',
          readable: '',
          createDate: DateTime.now(),
          favorite: true,
          dateTimeModification:
              DateTime(DateTime.daysPerWeek, DateTime.wednesday))));

  test('should add my note and order', () {
    bloc.eventSink.add(AddNote(
        note: Note(
            title: "Crazy",
            content: '',
            readable: '',
            createDate: DateTime.now(),
            favorite: true,
            dateTimeModification:
                DateTime(DateTime.daysPerWeek, DateTime.wednesday))));

    int leng = bloc.getIndex();

    expect(leng, 1); });
  test('should update my note and order', () {
    expect("", "");
  });
  test('should delete my note and order', () {});
  test('should getAllNotes my note and order', () {});

  test('should getAllData from database and order in this bloc', () {});
}
