import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_project/data/repositories/Store_repository.dart';
import 'package:notes_project/domain/entities/User.dart';
import 'package:notes_project/domain/entities/folder.dart';
import 'package:notes_project/domain/enums/enums.dart';
import 'package:notes_project/injector/instance_injector.dart';

void main() {
  final Injector inject =
      Injector.singleton(); //we inject here our dependencies
  List<Folder> sortNoteListByPin(List<Folder> list) {
    List<Folder> pinnedNotes = [];
    List<Folder> unpinnedNotes = [];

    for (var note in list) {
      if (note.isPin) {
        pinnedNotes.add(note);
      } else {
        unpinnedNotes.add(note);
      }
    }

    pinnedNotes.addAll(unpinnedNotes);

    return pinnedNotes;
  }

  test('should get to me a dependency that i want', () async {
    inject.registerInstance<StoreRepository>(instance: StoreRepository());
    final StoreRepository interface = inject.Get<StoreRepository>();
    expect(interface, inject.Get<StoreRepository>());
  });

  test('should get authenticate user', () async {
    String generateAsciiCode(int length) {
      var rand = Random();
      var codeUnits = List.generate(
        length,
        (index) => rand.nextInt(255),
      );
      return String.fromCharCodes(codeUnits);
    }

    print(generateAsciiCode(20));
  });

  test("Should print a time ago from last year", () {
  });

  test("Should print one String with the value of TypeUser", () {
    User user = User(
        id: "ansdsadi1",
        username: "",
        avatar: "",
        email: "",
        encryptedPass: "",
        token: "",
        type: TypeUser.guess);
    expect(user.type.name, TypeUser.guess.name);
  });

  test('should sort my list by inPin type', () async {
    List<Folder> list = [
      Folder(
          name: "Name",
          descriptionFolder: "IsFolder",
          isPin: false,
          creation: DateTime.now()),
      Folder(
          name: "Name",
          descriptionFolder: "IsFolder",
          isPin: true,
          creation: DateTime.now()),
      Folder(
          name: "Name",
          descriptionFolder: "IsFolder",
          isPin: true,
          creation: DateTime.now()),
      Folder(
          name: "Name",
          descriptionFolder: "IsFolder",
          isPin: true,
          creation: DateTime.now())
    ];
    var listSorted = sortNoteListByPin(list);
    expect(listSorted, sortNoteListByPin(list));
  });
}
