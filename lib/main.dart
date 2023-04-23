import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_project/UI/notes/notePage.dart';
import 'package:notes_project/data/repositories/Store_repository.dart';
import 'package:notes_project/data/repositories/account_repository.dart';
import 'package:notes_project/data/repositories/note_repository.dart';
import 'package:notes_project/injector/dependency_injector.dart';

  final Injector inject = Injector.singleton();//we inject here our dependencies

void main() {
  //dependencies

  inject.registerDependency<NoteRepository>(dependency: NoteRepository());
  inject.registerDependency<StoreRepository>(dependency: StoreRepository());
  inject.registerDependency<AccountRepository>(dependency: AccountRepository());

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
    );
  }
}
