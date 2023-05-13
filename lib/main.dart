import 'package:flutter/material.dart';
import 'package:notes_project/UI/home/HomePage.dart';
import 'package:notes_project/UI/home/controller/HomeController.dart';
import 'package:notes_project/UI/notes/controller/NoteController.dart';
import 'package:notes_project/constant.dart';
import 'package:notes_project/data/local%20/preferences/old_images_key.dart';
import 'package:notes_project/data/local%20/sqflite/note_local_repo.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:notes_project/data/repositories/Store_repository.dart';
import 'package:notes_project/data/repositories/account_repository.dart';
import 'package:notes_project/data/repositories/note_repository.dart';
import 'package:notes_project/domain/enums/enums.dart';
import 'package:notes_project/injector/instance_injector.dart';
import 'appThemes.dart';
import 'blocs/blocs.dart';

final locator = Injector.singleton();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

void setup() {
  //preferences
  locator.registerInstance<OldImagesPrefService>(
      instance: OldImagesPrefService());

  //Repositories
  locator.registerInstance<NoteRepository>(instance: NoteRepository());
  locator.registerInstance<NoteLocalRepository>(
      instance: NoteLocalRepository());
  locator.registerInstance<StoreRepository>(instance: StoreRepository());
  locator.registerInstance<AccountRepository>(instance: AccountRepository());

  //Controllers
  locator.registerInstance<HomeController>(instance: HomeController());
  locator.registerInstance<NoteController>(
      instance: NoteController(
          localDatabase: locator.Get<NoteLocalRepository>(),
          database: locator.Get<NoteRepository>()));

  //Blocs
  locator.registerInstance<NoteBloc>(
      instance: NoteBloc(NoteRepository(), NoteLocalRepository()));
  locator.registerInstance(instance: FolderBloc());
  locator.registerInstance<UserBloc>(instance: UserBloc());
  locator.registerInstance<CheckBloc>(instance: CheckBloc(initial: CheckInitialState()));
}
