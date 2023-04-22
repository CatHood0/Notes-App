import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/domain/repository/notes/INoteRepo.dart';

class SyncronizeDataUseCase {
  final INoteRepository noteRepository;
  SyncronizeDataUseCase({
    required this.noteRepository,
  });

  Stream<List<note>> syncronizeData({required idAccount}) async* {
    yield* noteRepository.syncronizeData(idAccount: idAccount);
  }
}
