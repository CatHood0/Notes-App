import 'dart:async';
import 'package:notes_project/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/bloc/Notes/NoteStates.dart';
import 'package:notes_project/domain/entities/Note.dart';

class NoteBloc {
  List<note> _notes = [];
  final _noteStateController = StreamController<NoteState>.broadcast(
    onListen: () => print("Listening note states"),
  );
  final _eventStreamController = StreamController<NoteEvent>();

  Stream<NoteState> get stateStream => _noteStateController.stream;
  StreamSink<NoteEvent> get eventSink => _eventStreamController.sink;

  NoteBloc() {
    _noteStateController.add(InitialNoteState());
    _eventStreamController.stream.listen(_handleEvent);
  }

  void _handleEvent(NoteEvent event) async {
    if (event is AddNote) {
      _noteStateController.add(LoadingNotes());
      _notes.add(event.Note);
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is DeleteNote) {
      _noteStateController.add(LoadingNotes());
      if (_notes[event.index].content!=null) {
        _notes.removeAt(event.index);
        _noteStateController.add(LoadedNotes(notes: _notes));
      } else {
        _noteStateController
            .add(NoteNotFound(onError: "This note can't be deleted"));
        Future.delayed(const Duration(seconds: 2));
        _noteStateController.add(LoadedNotes(notes: _notes));
      }
    } else if (event is UpdateNote) {
      _notes[event.index] = event.Note;
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is FavoriteNote) {
      _noteStateController.add(LoadingNotes());
      _notes[event.index].favorite = event.isFavorite;
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is SearchNote) {
      _noteStateController.add(LoadingNotes());
      if (event.search != "" ||
          event.search!.isNotEmpty ||
          event.search != null) {
        final notes = _notes.where((Note) {
          final titleLower = Note.title.toLowerCase();
          final contentLower = Note.content!.toLowerCase();
          final searchLower = event.search!.toLowerCase();
          return titleLower.contains(searchLower) ||
              contentLower.contains(searchLower);
        });
        if (notes.isEmpty) {
          _noteStateController.add(NoteNotFound(onError: "Note not found"));
        } else {
          _noteStateController.add(LoadedNotes(notes: notes.toList()));
        }
      } else if (event.search!.isEmpty) {
        _noteStateController.add(LoadedNotes(notes: _notes));
      }
    } else if (event is SaveNotesFiles) {
    } else if (event is RestoreNoteFiles) {
      _noteStateController.add(LoadingNotes());
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is SortNotesEvents) {
      _noteStateController.add(LoadingNotes());
      _notes =
          event.notes; //we get a list sorted by the type that the user selected
      _noteStateController.add(LoadedNotes(notes: _notes));
    }
  }

  //Needs to get the index for updating when we create a new note
  int getIndex({required String id}) {
    return _notes.length;
  }

  List<note> getAllNotes(){
    return [..._notes];
  }

  note getNote({required String id}) {
    note? Note;
    for (var notes in _notes) {
      if (notes.key == id) {
        Note = notes;
      }
    }
    return Note!;
  }

  void dispose() {
    _eventStreamController.close();
    _noteStateController.close();
  }
}

final NoteBloc bloc = NoteBloc();
