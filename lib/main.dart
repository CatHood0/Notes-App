import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_project/UI/home/HomePage.dart';
import 'package:notes_project/constant.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:notes_project/data/repositories/Store_repository.dart';
import 'package:notes_project/data/repositories/account_repository.dart';
import 'package:notes_project/data/repositories/note_repository.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/users/UserBloc.dart';
import 'package:notes_project/enums.dart';
import 'package:notes_project/injector/DS_injector.dart';
import 'package:notes_project/injector/blocs_injector.dart';

import 'domain/bloc/Store/StoreBloc.dart';

final inject = Injector.singleton(); //we inject here our dependencies
final blocInject = BlocInjector.singleton(); //we can inject our blocs here
void main() async {
  //dependencies
  inject.registerDependency<NoteRepository>(dependency: NoteRepository());
  inject.registerDependency<StoreRepository>(dependency: StoreRepository());
  inject.registerDependency<AccountRepository>(dependency: AccountRepository());
  blocInject.registerBloc<NoteBloc>(
      bloc: NoteBloc(repository: NoteRepository()));
  blocInject.registerBloc<StoreBloc>(bloc: StoreBloc());
  blocInject.registerBloc<UserBloc>(bloc: UserBloc());
  timeago.setLocaleMessages('en', MyCustomMessages());
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.appThemeData[AppTheme.darkTheme],
      darkTheme: ThemeData.dark(
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
