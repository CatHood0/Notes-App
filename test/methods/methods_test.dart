import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:notes_project/data/repositories/Store_repository.dart';
import 'package:notes_project/domain/entities/User.dart';
import 'package:notes_project/domain/enums/enums.dart';
import 'package:notes_project/injector/instance_injector.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  final Injector inject =
      Injector.singleton(); //we inject here our dependencies
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
    String moment = timeago.format(DateTime.now());
    expect(moment, timeago.format(DateTime.now()));
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
}
