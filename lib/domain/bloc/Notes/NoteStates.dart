import 'package:notes_project/domain/entities/Note.dart';

abstract class NoteState {}

class LoadingNotes extends NoteState {}

class InitialNoteState extends NoteState{
  List<Note> notes = [];
  String message = 'Loading your data';
}

class FirstTimeNoteState extends NoteState{
  String message = '''¡Adding right now your notes and approach your time!''';
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
  final List<Note> notes;
  final bool showStar;
  LoadedNotes({required this.notes,this.showStar = true});
}
