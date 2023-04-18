import 'dart:async';
import 'package:notes_project/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/bloc/Notes/NoteStates.dart';
import 'package:notes_project/domain/entities/Note.dart';

class NoteBloc {
  List<note> _notes = [];
  final _noteStateController = StreamController<NoteState>.broadcast();
  final _eventStreamController = StreamController<NoteEvent>();

  Stream<NoteState> get stateStream => _noteStateController.stream;
  StreamSink<NoteEvent> get eventSink => _eventStreamController.sink;

  NoteBloc() {
    _eventStreamController.stream.listen(_handleEvent);
  }

  void _handleEvent(NoteEvent event) async {
    if (event is AddNote) {
      _noteStateController.add(LoadingNotes());
      _notes.add(event.Note);
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is DeleteNote) {
    } else if (event is UpdateNote) {
      _notes[event.index] = event.Note;
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is FavoriteNote) {
      _noteStateController.add(LoadingNotes());
      _notes[event.index].favorite = event.isFavorite;
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is SearchNote) {
    } else if (event is SaveNotesFiles) {
    } else if (event is RestoreNoteFiles) {
      _noteStateController.add(LoadingNotes());
      _notes.add(
        note(
            title: "Pi pi pupu check",
            content: "Contenido",
            createDate: DateTime.now(),
            key: '0',
            favorite: true,
            dateTimeModification: DateTime.now()),
      );
      _noteStateController.add(LoadedNotes(notes: _notes));
    }
  }

  note getNote({required String id}){
    note? Note;
    _notes.forEach((notes) {if(notes.key == id) {
       Note = notes;
    }});
    return Note!; 
  }

  void dispose(){
    _eventStreamController.close();
    _noteStateController.close();
  }

}
