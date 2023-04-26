import 'package:notes_project/domain/repository/notes/INoteRepo.dart';

import '../../entities/Note.dart';

class SearchNoteUseCase{
  final INoteRepository noteRepository;
  SearchNoteUseCase({required this.noteRepository});

  Future<List<Note>> search({required String text}){
    return noteRepository.search(text: text);
  }
}