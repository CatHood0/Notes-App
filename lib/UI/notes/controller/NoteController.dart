import 'package:notes_project/domain/repository/notes/INoteRepo.dart';
import '../../../domain/entities/Note.dart';
import '../../../domain/local repositories/note/INoteLocalRepo.dart';

class NoteController {
  final INoteLocalRepository localDatabase;
  final INoteRepository database;
  Set<String> oldImages = Set<String>();

  NoteController(
      {required this.localDatabase,
      required this.database}) {
    localDatabase.openDatabase();
  }

  void closeLocalDatabase() {
    localDatabase.closeDatabase();
  }


  Future<String> uploadImageToCloud({required String image}) async {
    return '';
  }

  Future<bool> deleteImageFromCloud({required List<String> images}) async {
    try {
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void updateNote({required Note note}) {}

  void insertNote({required Note note}) {}

  void deleteNote({required int id}) {}

  void updateLocalNote({required Note note}) async {
    localDatabase.update(obj: note);
  }

  Future<int> insertLocalNote({required Note note}) async {
    return localDatabase.create(obj: note);
  }

  void deleteLocalNote({required int id}) {
    localDatabase.delete(id: id);
  }
}

    //only use this for knowing if the newImages not contains a image that's in oldImages
    // oldImages.toSet().difference(newImages.toSet()).forEach((image) {
    //   print("New images does not contain this one: $image");
    // });