import '../../domain/entities/Note.dart';

abstract class NoteEvent {}

class AddNote extends NoteEvent{
  final note Note;
  AddNote({required this.Note});
}

class SaveNotesFiles extends NoteEvent{
  final List<note> notes;
  SaveNotesFiles({required this.notes});
}

class RestoreNoteFiles extends NoteEvent{}

class UpdateNote extends NoteEvent{
  final int index;
  final note Note;
  UpdateNote({required this.index, required this.Note});
}

class DeleteNote extends NoteEvent{
  final int index;
  DeleteNote({required this.index});
}

class SearchNote extends NoteEvent{
  final String? search;
  SearchNote({required this.search});
}

class FavoriteNote extends NoteEvent{
  final int index;
  final bool isFavorite;
  FavoriteNote({required this.index, required this.isFavorite});
}

