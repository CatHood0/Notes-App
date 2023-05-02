import 'dart:async';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/domain/bloc/Notes/NoteStates.dart';
import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/domain/repository/notes/INoteRepo.dart';
import '../../local repositories/note/INoteLocalRepo.dart';

class NoteBloc {
  List<Note> _notes = [];
  List<Note> resultSearchNote = [];
  String? _oldSearch = null;
  final INoteRepository repository;
  final INoteLocalRepository localRepository;
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

  NoteBloc({required this.repository, required this.localRepository}) {
    _noteStateController.add(InitialNoteState());
    _eventStreamController.stream.listen(_handleEvent);
  }

  void _handleEvent(NoteEvent event) async {
    await localRepository.openDatabase();
    if (event is AddNote) {
      _noteStateController.add(LoadingNotes());
      _notes.add(event.note);
      if (event.note.favorite) {
        _notes = sortFolderListByPin(_notes);
      }
      _currentLenghtNotesController.add(_notes.length);
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is DeleteNote) {
      _noteStateController.add(LoadingNotes());
      _notes.removeAt(event.index);
      _notes = sortFolderListByPin(_notes);
      _currentLenghtNotesController.add(_notes.length);
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is UpdateNote) {
      _notes[event.index] = event.notes;
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is FavoriteNote) {
      _noteStateController.add(LoadingNotes());
      var note = _notes[event.index].copyWith(favorite: event.isFavorite);
      _notes[event.index] = note;
      if (resultSearchNote.isEmpty) {
        _notes = sortFolderListByPin(_notes);
        _noteStateController.add(LoadedNotes(notes: _notes, showStar: true));
      } else {
        _notes[event.index] = note;
        resultSearchNote = searchNote(_oldSearch, _notes);
        _noteStateController.add(LoadedNotes(notes: resultSearchNote, showStar: false));
      }
    } else if (event is SearchNote) {
      _noteStateController.add(LoadingNotes());
      if (event.search != "" ||
          event.search!.isNotEmpty ||
          event.search != null) {
        resultSearchNote = searchNote(event.search!, _notes);
        await Future.delayed(const Duration(milliseconds: 350));
        if (resultSearchNote.isEmpty) {
          _currentLenghtNotesController.add(0);
          _noteStateController.add(NoteNotFound(onError: "Note(s) not found"));
        } else {
          _oldSearch = event.search;
          if (event.search == null || event.search == "") {
            resultSearchNote = [];
            _notes = await _getNotesFromLocalDatabase();
            _notes = sortFolderListByPin(_notes);
            _currentLenghtNotesController.add(_notes.length);
            _noteStateController.add(LoadedNotes(notes: _notes, showStar: true));
          } else {
            _currentLenghtNotesController.add(resultSearchNote.toList().length);
            _noteStateController
                .add(LoadedNotes(notes: resultSearchNote.toList(), showStar: false));
          }
        }
      }
    } else if (event is SaveNotesFiles) {
    } else if (event is RestoreNoteFiles) {
      _notes = await _getNotesFromLocalDatabase();
      _notes = sortFolderListByPin(_notes);
      _currentLenghtNotesController.add(_notes.length);
      _noteStateController.add(LoadedNotes(notes: _notes));
    } else if (event is SortNotesEvents) {
      _noteStateController.add(LoadedNotes(notes: _notes));
    }
  }

  Future<List<Note>> _getNotesFromLocalDatabase() async {
    return localRepository.getAllNotes();
  }

  List<Note> searchNote(String? search, List<Note> notes) {
    var result = _notes.where((Note) {
      final titleLower = Note.title.toLowerCase();
      final searchLower = search!.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    return result;
  }

  List<Note> sortFolderListByPin(List<Note> list) {
    List<Note> favoriteNotes = [];
    List<Note> unFavoriteNotes = [];
    for (var note in list) {
      if (note.favorite) {
        favoriteNotes.add(note);
      } else {
        unFavoriteNotes.add(note);
      }
    }
    favoriteNotes.addAll(unFavoriteNotes);
    return favoriteNotes;
  }

  //Needs to get the index for updating when we create a new note
  int getIndex() {
    return _notes.length;
  }

  void dispose() {
    localRepository.closeDatabase();
    _currentLenghtNotesController.close();
    _eventStreamController.close();
    _noteStateController.close();
  }
}
