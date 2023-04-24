import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_project/UI/home/HomePage.dart';
import 'package:notes_project/UI/notes/notePage.dart';
import 'package:notes_project/constant.dart';
import 'package:notes_project/data/repositories/Store_repository.dart';
import 'package:notes_project/data/repositories/account_repository.dart';
import 'package:notes_project/data/repositories/note_repository.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/injector/DS_injector.dart';
import 'package:notes_project/injector/blocs_injector.dart';

final Injector inject = Injector.singleton(); //we inject here our dependencies
final BlocInjector blocInject =
    BlocInjector.singleton(); //we can inject our blocs here
void main() {
  //dependencies
  inject.registerDependency<NoteRepository>(dependency: NoteRepository());
  inject.registerDependency<StoreRepository>(dependency: StoreRepository());
  inject.registerDependency<AccountRepository>(dependency: AccountRepository());
  blocInject.registerBloc<NoteBloc>(dependency: NoteBloc());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
