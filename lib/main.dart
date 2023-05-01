import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_project/UI/R%20and%20B/RestoreBackupPage.dart';
import 'package:notes_project/UI/home/HomePage.dart';
import 'package:notes_project/constant.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:notes_project/data/repositories/Store_repository.dart';
import 'package:notes_project/data/repositories/account_repository.dart';
import 'package:notes_project/data/repositories/note_repository.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/users/UserBloc.dart';
import 'package:notes_project/domain/enums/enums.dart';
import 'package:notes_project/injector/instance_injector.dart';

import 'domain/appThemes.dart';
import 'domain/bloc/Store/StoreBloc.dart';

final locator = Injector.singleton(); //we inject here our dependencies
void main() async {
  //dependencies
  setup();
  timeago.setLocaleMessages('en', MyCustomMessages());
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.appThemeData[AppTheme.darkTheme],
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

void setup(){
  locator.registerInstance<NoteRepository>(instance: NoteRepository());
  locator.registerInstance<StoreRepository>(instance:StoreRepository());
  locator.registerInstance<AccountRepository>(instance:AccountRepository());
  locator.registerInstance<NoteBloc>(instance:NoteBloc(repository: NoteRepository()));
  locator.registerInstance<StoreBloc>(instance:StoreBloc());
  locator.registerInstance<UserBloc>(instance:UserBloc());
}