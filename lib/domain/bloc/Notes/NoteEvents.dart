// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../entities/Note.dart';
import '../../enums/enums.dart';

abstract class NoteEvent {}

class AddNote extends NoteEvent {
  final Note note;
  AddNote({required this.note});
}

class SaveNotesFiles extends NoteEvent {
  final List<Note> notes;
  SaveNotesFiles({required this.notes});
}

class SortNotesEvents extends NoteEvent {
  List<Note> notes = [];
  SortNotesEvents({required TypeSort sort}) {
  //here we place the logic for getting the last typerSort selected
    /*switch (typeSort) {
      case SortByNote.CreateDate:
        notes.sort((a, b) => a.createDate.compareTo(b.createDate));
        break;
      case SortByNote.DateModification:
        notes.sort(
            (a, b) => b.dateTimeModification.compareTo(a.dateTimeModification));
        break;
      case SortByNote.Title:
        notes.sort((a, b) => b.title.compareTo(a.title));
        break;
    }*/
  }
}

class RestoreNoteFiles extends NoteEvent {}


class RestoreNoteFilesByIdFolder extends NoteEvent {
  final int id;
  RestoreNoteFilesByIdFolder({
    required this.id,
  });
  
}

class UpdateNote extends NoteEvent {
  final int index;
  final Note notes;
  UpdateNote({required this.index, required this.notes});
}

class DeleteNote extends NoteEvent {
  final int index;
  DeleteNote({required this.index});
}

class SearchNote extends NoteEvent {
  final String? search;
  SearchNote({required this.search});
}

class FavoriteNote extends NoteEvent {
  final int index;
  final bool isFavorite;
  FavoriteNote({required this.index, required this.isFavorite});
}
