import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_project/UI/home/HomePage.dart';
import 'package:notes_project/data/repositories/Store_repository.dart';
import 'package:notes_project/data/repositories/account_repository.dart';
import 'package:notes_project/data/repositories/note_repository.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/users/UserBloc.dart';
import 'package:notes_project/injector/DS_injector.dart';
import 'package:notes_project/injector/blocs_injector.dart';

import 'domain/bloc/Store/StoreBloc.dart';

final Injector inject = Injector.singleton(); //we inject here our dependencies
final BlocInjector blocInject =
    BlocInjector.singleton(); //we can inject our blocs here
void main() async {
  //dependencies
  inject.registerDependency<NoteRepository>(dependency: NoteRepository());
  inject.registerDependency<StoreRepository>(dependency: StoreRepository());
  inject.registerDependency<AccountRepository>(dependency: AccountRepository());
  blocInject.registerBloc<NoteBloc>(bloc: NoteBloc(repository: NoteRepository()));
  blocInject.registerBloc<StoreBloc>(bloc: StoreBloc());
  blocInject.registerBloc<UserBloc>(bloc: UserBloc());
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
