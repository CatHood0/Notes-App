import 'dart:convert';
import 'dart:developer';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_project/data/local%20/preferences/old_images_key.dart';
import 'package:notes_project/domain/repository/notes/INoteRepo.dart';
import '../../../domain/entities/Note.dart';
import '../../../domain/local repositories/note/INoteLocalRepo.dart';

class NoteController {
  final INoteLocalRepository localDatabase;
  final INoteRepository database;
  late final OldImagesPrefService _pref;
  Set<String> oldImages = Set<String>();

  NoteController(
      {required this.localDatabase,
      required this.database,
      required OldImagesPrefService pref}) {
    _pref = pref;
    _pref.openShared();
    localDatabase.openDatabase();
  }

  void closeDatabase() {
    localDatabase.closeDatabase();
  }

  void deleteOldImages() async {
    log("eliminating...");
    var imagesFromPref = await _pref.oldImages;
    bool error = false;
    if (oldImages.toList().isNotEmpty) {
      error = await deleteImageFromCloud(images: oldImages.toList());
      if (!error) {
        _pref.removeAllOldImages;
      } else if (imagesFromPref != null) {
        imagesFromPref
            .where(((image) => !oldImages.contains(image)))
            .forEach((image) {
          oldImages.add(image);
        });
        _pref.saveOldImages(oldImages.toList());
      }
      oldImages = Set<String>();
      log("Finished");
    } else if (oldImages.toList().isEmpty) {
      log("There aren't images in the editor or there aren't deleted ones");
    }
  }

  void compare(
      {required QuillController newController,
      required QuillController oldController}) async {
    final Set<String?> newImages =
        _getImagesFromController(controller: newController);
    if (oldImages.toList().isEmpty) {
      oldImages = _getImagesFromController(controller: oldController);
    } else {
      final listAux = _getImagesFromController(controller: oldController);
      listAux.forEach((image) {
        log('new image added to old images ${image}');
        oldImages.add(image);
      });
    }
    oldImages.toSet().difference(newImages.toSet()).forEach((image) {
      print("New images does not contain this one: $image");
    });

    newImages.toSet().intersection(oldImages.toSet()).forEach((image) {
      print("$image has been eliminated from old images.");
      oldImages.remove(image);
    });
    var imagesFromPref = await _pref.oldImages;
    if (imagesFromPref == null) {
      _pref.saveOldImages(oldImages.toList());
    }
  }

  Set<String> _getImagesFromController({required QuillController controller}) {
    Set<String> urlList = Set<String>();
    final json = jsonEncode(controller.document.toDelta());
    final List<dynamic> delta = jsonDecode(json);
    for (final line in delta) {
      if (line.containsKey('insert')) {
        final value = line['insert'];
        if (value is Map<String, dynamic> && value.containsKey('image')) {
          final url = value['image'];
          if (url is String &&
              (!url.startsWith('http://') || !url.startsWith('https://'))) {
            urlList.add(url);
          }
        }
      }
    }
    return urlList;
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
