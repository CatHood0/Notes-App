import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/repository/notes/INoteRepo.dart';

class SyncronizeDataUseCase {
  final INoteRepository noteRepository;
  SyncronizeDataUseCase({
    required this.noteRepository,
  });

  StreamNoteEither syncronizeData({required idAccount}) async* {
    yield* noteRepository.syncronizeData(idAccount: idAccount);
  }
}
