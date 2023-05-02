// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../entities/folder.dart';

abstract class FolderEvent extends Equatable {
  const FolderEvent();

  @override
  List<Object?> get props => [];
}

class GetAllFoldersEvent extends FolderEvent{}

class FolderAdded extends FolderEvent {
  final Folder folder;
  FolderAdded({
    required this.folder,
  });
  @override
  List<Object?> get props => [folder];
}

class FolderRemoved extends FolderEvent {
  final int index;
  FolderRemoved({
    required this.index,
  });
}

class FolderUpdated extends FolderEvent {
  final Folder folder;
  final int index;
  final bool oldPin;
  FolderUpdated({
    required this.folder,
    required this.index,
    required this.oldPin,
  });

  @override
  List<Object?> get props => [folder];
}

class FolderSearchEvent extends FolderEvent {
  final String? search;
  FolderSearchEvent({
    required this.search,
  });
}

class FolderPinTopEvent extends FolderEvent {
  final int index;
  FolderPinTopEvent({
    required this.index,
  });
}

class FolderDesPinTopEvent extends FolderEvent {
  final int index;
  FolderDesPinTopEvent({
    required this.index,
  });
}
