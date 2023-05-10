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
  List<String> oldImages = [];

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
    if (oldImages.isNotEmpty) {
      error = await deleteImageFromCloud(images: oldImages);
      if (error) {
        if (imagesFromPref!.isNotEmpty) {
          imagesFromPref.forEach((image) {
            if (!oldImages.contains(image)) {
              oldImages.add(image);
            }
          });
          _pref.saveOldImages(oldImages);
        }
      } else {
        _pref.removeAllOldImages;
      }
      oldImages = [];
      log("Finished");
    } else {
      log("There aren't images in the editor or there aren't deleted ones");
    }
  }

  void compare(
      {required QuillController newController,
      required QuillController oldController}) async {
    final List<String?> newImages =
        _getImagesFromController(controller: newController);
    if (oldImages.isEmpty) {
      oldImages = _getImagesFromController(controller: oldController);
    } else {
      final listAux = _getImagesFromController(controller: oldController);
      listAux.forEach((image) {
        if (!oldImages.contains(image) && !newImages.contains(image)) {
          print('new image added to old images ${image}');
          oldImages.add(image);
        }
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
    if (imagesFromPref!.isEmpty) {
      _pref.saveOldImages(oldImages);
    }
  }

  List<String> _getImagesFromController({required QuillController controller}) {
    List<String> urlList = [];
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
