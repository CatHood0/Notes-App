import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_project/UI/notes/controller/NoteController.dart';
import 'package:notes_project/Widgets/snackMessage.dart';
import 'package:notes_project/data/local%20/preferences/old_images_key.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/helper/db_helper.dart';
import '../../blocs/blocs.dart';
import 'dart:async';
import 'package:internet_connectivity_checker/internet_connectivity_checker.dart';
import 'package:notes_project/UI/home/widget/homeAppBarWidget.dart';
import 'package:notes_project/UI/home/widget/homeHeaderWidget.dart';
import 'package:notes_project/UI/home/widget/homeNoteListWidget.dart';
import 'package:notes_project/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final NoteBloc noteBloc = locator.Get<NoteBloc>();
  bool hadConnectionBefore = false, showAdvice = false;
  final DBHelper _db = DBHelper.instance;
  late StreamSubscription subscription;

  @override
  void initState() {
    _db.database();
    noteBloc.eventSink.add(RestoreNoteFiles());
    super.initState();
    subscription = ConnectivityChecker(interval: const Duration(seconds: 5))
        .stream
        .listen(showConnectionSnackBar);
  }

  @override
  void dispose() {
    _db.closeDatabase();
    locator.Get<NoteController>().closeDatabase();
    noteBloc.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabBar = TabController(length: 2, vsync: this);
    DateTime now = DateTime.now();
    return Scaffold(
      body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            HomeAppBarWidget(now: now),
            HomeHeaderWidget(tabBar: tabBar),
            NoteListWidget(),
            SliverToBoxAdapter(
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Task",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ]),
    );
  }

  void showConnectionSnackBar(var result) async {
    print(result.toString());
    final hasInternet = result != false;
    if (hasInternet) {
      List<String>? imagesFromPref =
          await locator.Get<OldImagesPrefService>().oldImages;
      if (imagesFromPref != null || imagesFromPref!.isNotEmpty) {
        log("Saved old images isn't empty");
        await locator.Get<NoteController>()
            .deleteImageFromCloud(images: imagesFromPref);
        log("Deleted old images");
        locator.Get<OldImagesPrefService>().removeAllOldImages;
      }
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (hasInternet && hadConnectionBefore && !showAdvice) {
      showAdvice = true;
      SnackMessage.showSnackbarMessage(
        context: context,
        message: "Connection established",
        backgroudColor: Colors.green,
      );
    } else if (!hasInternet) {
      hadConnectionBefore = true;
      showAdvice = false;
      SnackMessage.showSnackbarMessage(
        context: context,
        message:
            'Please, check your connection. The changes will not be apply if you dont have a connection',
        duration: const Duration(days: 1000000),
        backgroudColor: Colors.red,
      );
    }
  }
}
