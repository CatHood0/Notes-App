import 'package:notes_project/domain/repository/notes/INoteRepo.dart';
import '../../entities/Note.dart';

class crud_case_notes {
  final INoteRepository repository;

  crud_case_notes(this.repository);

  Future<void> update({required note Note}) async {
    repository.update(object: Note);
  }

  Future<void> deleteNote({required String key}) async {
    repository.delete(key: key);
  }

  Future<void> create({required note Note}) async {
    repository.create(object: Note);
  }

  Future<List<note>> getNotes({required String keyUser}) async {
    return repository.getAllData(keyUser: keyUser);
  }
}
