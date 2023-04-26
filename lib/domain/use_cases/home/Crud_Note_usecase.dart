import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/repository/notes/INoteRepo.dart';
import '../../entities/Note.dart';

class CrudNoteUseCase{
  final INoteRepository noteRepository;
  CrudNoteUseCase({required this.noteRepository});

  Future<void> update({required Note Note}) async {
    noteRepository.update(obj: Note);
  }

  Future<void> deleteNote({required String key}) async {
    noteRepository.delete(idObj: key);
  }

  Future<void> create({required Note Note}) async {
    noteRepository.create(obj: Note);
  }

  StreamNoteEither getNotes({required String keyUser}) async* {
    yield* noteRepository.getAllNotes(idAccount: keyUser); 
  }
}
