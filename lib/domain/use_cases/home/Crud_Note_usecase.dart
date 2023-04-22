import 'package:notes_project/domain/repository/notes/INoteRepo.dart';
import '../../entities/Note.dart';

class CrudNoteUseCase{
  final INoteRepository noteRepository;
  CrudNoteUseCase({required this.noteRepository});

  Future<void> update({required note Note}) async {
    noteRepository.update(obj: Note);
  }

  Future<void> deleteNote({required String key}) async {
    noteRepository.delete(idObj: key);
  }

  Future<void> create({required note Note}) async {
    noteRepository.create(obj: Note);
  }

  Stream<List<note>> getNotes({required String keyUser}) async* {
    yield* noteRepository.getAllNotes(idAccount: keyUser); 
  }
}
