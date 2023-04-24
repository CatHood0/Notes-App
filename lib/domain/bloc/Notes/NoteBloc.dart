import 'dart:async';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/domain/bloc/Notes/NoteStates.dart';
import 'package:notes_project/domain/entities/Note.dart';

class NoteBloc {
  List<note> _notes = [];
  final _noteStateController = StreamController<NoteState>.broadcast(
    onListen: () => print("Listening note states"),
    onCancel: () => print("Cancelling note state"),
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
      print(event.Note.content);
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is DeleteNote) {
      _noteStateController.add(LoadingNotes());
      _notes.removeAt(event.index);
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
          _noteStateController.add(NoteNotFound(onError: "Note(s) not found"));
        } else {
          _noteStateController.add(LoadedNotes(notes: notes.toList()));
        }
      } else if (event.search!.isEmpty) {
        _noteStateController.add(LoadedNotes(notes: _notes));
      }
    } else if (event is SaveNotesFiles) {
    } else if (event is RestoreNoteFiles) {
      _noteStateController.add(LoadingNotes());
      await Future.delayed(const Duration(seconds: 2));
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is SortNotesEvents) {
      _notes.add(note(
          title: "Hello",
          content: '',
          createDate: DateTime.now(),
          key: '1',
          favorite: false,
          updates: 1,
          dateTimeModification: DateTime.now())); //we get a list sorted by the type that the user selected
      _noteStateController.add(LoadedNotes(notes: _notes));
    }
  }

  //Needs to get the index for updating when we create a new note
  int getIndex() {
    return _notes.length;
  }

  List<note> getAllNotes() {
    return [..._notes];
  }

  note getNote({required String id}) {
    late note? Note = null;
    _notes.forEach((element) {
      if (element.key == id) {
        Note = element;
      }
    });
    return Note!;
  }

  void dispose() {
    _eventStreamController.close();
    _noteStateController.close();
  }
}
