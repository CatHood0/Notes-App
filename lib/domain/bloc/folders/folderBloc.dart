import 'package:notes_project/domain/bloc/folders/folderEvent.dart';
import 'package:notes_project/domain/bloc/folders/folderState.dart';
import '../../entities/folder.dart';
import 'dart:async';

class FolderBloc {
  List<Folder> _folders = <Folder>[];
  final StreamController<FolderState> _stateController =
      StreamController<FolderState>.broadcast();
  final StreamController<FolderEvent> _eventController =
      StreamController<FolderEvent>.broadcast();
  final StreamController<int> _currentFoldersLenght =
      StreamController<int>.broadcast();
  Stream<int> get currentFoldersLenght =>
      _currentFoldersLenght.stream; // for show the amount from folder
  StreamSink<FolderEvent> get eventSink => _eventController.sink;
  Stream<FolderState> get streamState => _stateController.stream;

  FolderBloc() {
    _stateController.add(FolderInitialState());
    _eventController.stream.listen(_mapToEvent);
  }

  void _mapToEvent(FolderEvent event) async {
    if (event is FolderAdded) {
      _stateController.add(FolderLoadingState());
      _folders.add(event.folder);
      if (event.folder.isPin) {
        //if the user pinned the folder when he was creating it
        _folders = sortFolderListByPin(_folders);
      }
      _currentFoldersLenght.add(_folders.length);
      _stateController.add(FolderLoadedState(folders: _folders));
    } else if (event is FolderRemoved) {
      _folders.removeAt(event.index);
      _folders = sortFolderListByPin(_folders);
      _currentFoldersLenght.add(_folders.length);
      _stateController.add(FolderLoadedState(folders: _folders));
    } else if (event is FolderUpdated) {
      _folders[event.index] = event.folder;
      if (event.folder.isPin != event.oldPin) {
        _folders = sortFolderListByPin(_folders);
      }
      _stateController.add(FolderLoadedState(folders: _folders));
    } else if (event is FolderSearchEvent) {
      _stateController.add(FolderLoadingState());
      if (event.search!.isNotEmpty || event.search != null) {
        final folder = _folders.where((currentFolder) {
          final titleLower = currentFolder.name.toLowerCase();
          final descriptLower = currentFolder.descriptionFolder.toLowerCase();
          final searchLower = event.search!.toLowerCase();
          return titleLower.contains(searchLower) ||
              descriptLower.contains(searchLower);
        });
        if (folder.isEmpty) {
          _currentFoldersLenght.add(folder.length);
          _stateController.add(FolderNotFoundState());
        } else {
          _currentFoldersLenght.add(folder.length);
          _stateController.add(FolderLoadedState(folders: folder.toList()));
        }
      } else {
        _folders = await getAllFolders();
        _currentFoldersLenght.add(_folders.length);
        _stateController.add(FolderLoadedState(folders: _folders));
      }
    } else if (event is GetAllFoldersEvent) {
      _stateController.add(FolderLoadingState());
      _folders = await getAllFolders();
      _currentFoldersLenght.add(_folders.length);
      _stateController.add(FolderLoadedState(folders: _folders));
    } else if (event is FolderDesPinTopEvent) {
      //change value pin to negative
      _folders[event.index] = _folders[event.index].copyWith(pin: false);
      //sort the list
      _folders = sortFolderListByPin(_folders);
      _stateController.add(FolderLoadedState(folders: _folders));
    } else if (event is FolderPinTopEvent) {
      //change value pin
      _folders[event.index] = _folders[event.index].copyWith(pin: true);
      //sort the list
      _folders = sortFolderListByPin(_folders);
      _stateController.add(FolderLoadedState(folders: _folders));
    }
  }

  Future<List<Folder>> getAllFolders() async {
    return _folders;
  }

  List<Folder> sortFolderListByPin(List<Folder> list) {
    List<Folder> pinnedFolder = [];
    List<Folder> unPinnedFolder = [];
    for (var folder in list) {
      if (folder.isPin) {
        pinnedFolder.add(folder);
      } else {
        unPinnedFolder.add(folder);
      }
    }
    pinnedFolder.addAll(unPinnedFolder);
    return pinnedFolder;
  }

  void disposeCountFolders(){
    _currentFoldersLenght.close();
  }

  void dispose() {
    _currentFoldersLenght.close();
    _eventController.close();
    _stateController.close();
  }
}
