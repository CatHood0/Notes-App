import 'package:notes_project/domain/entities/Note.dart';

abstract class NoteState {}

class LoadingNotes extends NoteState {}

class InitialNoteState extends NoteState{
  List<note> notes = [];
}

class NoteNotFound extends NoteState {
  final String onError;
  NoteNotFound({required this.onError});
}

class ErrorState extends NoteState{
  final String onError;
  ErrorState({required this.onError});
}

class LoadedNotes extends NoteState {
  final List<note> notes;
  LoadedNotes({required this.notes});
}
