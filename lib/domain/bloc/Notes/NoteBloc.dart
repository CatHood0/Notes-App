import 'dart:async';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/domain/bloc/Notes/NoteStates.dart';
import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/domain/repository/notes/INoteRepo.dart';

class NoteBloc {
  final INoteRepository repository;
  List<Note> _notes = [];
  final _noteStateController = StreamController<NoteState>.broadcast(
    onListen: () => print("Listening note states"),
    onCancel: () => print("Cancelling note state"),
  );
  final _eventStreamController = StreamController<NoteEvent>();
  final _currentLenghtNotesController = StreamController<int>.broadcast(
    onListen: () => print("Listening current note length"),
    onCancel: () => print("Cancelling current note length"),
  );
  Stream<int> get stateLenghtStream => _currentLenghtNotesController.stream;
  Stream<NoteState> get stateStream => _noteStateController.stream;
  StreamSink<NoteEvent> get eventSink => _eventStreamController.sink;

  NoteBloc({required this.repository}) {
    _noteStateController.add(InitialNoteState());
    _eventStreamController.stream.listen(_handleEvent);
  }

  void _handleEvent(NoteEvent event) async {
    if (event is AddNote) {
      _noteStateController.add(LoadingNotes());
      _notes.add(event.note);
      _currentLenghtNotesController.add(_notes.length);
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is DeleteNote) {
      _noteStateController.add(LoadingNotes());
      _notes.removeAt(event.index);
      _currentLenghtNotesController.add(_notes.length);
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is UpdateNote) {
      _notes[event.index] = event.notes;
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is FavoriteNote) {
      _noteStateController.add(LoadingNotes());
      _notes[event.index] =
          _notes[event.index].copyWith(favorite: event.isFavorite);
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is SearchNote) {
      _noteStateController.add(LoadingNotes());
      if (event.search != "" ||
          event.search!.isNotEmpty ||
          event.search != null) {
        final notes = _notes.where((Note) {
          final titleLower = Note.title.toLowerCase();
          final searchLower = event.search!.toLowerCase();
          return titleLower.contains(searchLower);
        });
        await Future.delayed(const Duration(seconds: 1));
        if (notes.isEmpty) {
          _currentLenghtNotesController.add(0);
          _noteStateController.add(NoteNotFound(onError: "Note(s) not found"));
        } else {
          _currentLenghtNotesController.add(notes.toList().length);
          _noteStateController.add(LoadedNotes(notes: notes.toList()));
        }
      } else if (event.search!.isEmpty) {
        _currentLenghtNotesController.add(_notes.length);
        _noteStateController.add(LoadedNotes(notes: _notes));
      }
    } else if (event is SaveNotesFiles) {
    } else if (event is RestoreNoteFiles) {
      _notes.add(Note(
          title: "76",
          content: '{"insert": ""}',
          createDate: DateTime.now(),
          key: "32msakdm91m",
          favorite: false,
          updates: 1,
          dateTimeModification: DateTime.now()));
      _currentLenghtNotesController.add(_notes.length);
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is SortNotesEvents) {
      _noteStateController.add(LoadedNotes(notes: _notes));
    }
  }

  //Needs to get the index for updating when we create a new note
  int getIndex() {
    return _notes.length;
  }

  void dispose() {
    _currentLenghtNotesController.close();
    _eventStreamController.close();
    _noteStateController.close();
  }
}
