// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:notes_project/domain/entities/folder.dart';

abstract class FolderState {}

class FolderInitialState extends FolderState{
  final List<Folder> folders = [];
}

class FolderNotFoundState extends FolderState {
  String message = "Folder not found";
}

class FolderAlreadyExistsState extends FolderState {
  String message = "Folder already exists";
}

class FolderLoadedState extends FolderState {
  final List<Folder> folders;
  FolderLoadedState({
    required this.folders,
  });
}

class FolderLoadingState extends FolderState {}

class FolderHasErrorState extends FolderState {
  final String onError;
  FolderHasErrorState({
    required this.onError,
  }){
    throw onError;
  }
}
