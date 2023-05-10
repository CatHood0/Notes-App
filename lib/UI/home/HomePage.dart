import 'package:flutter/material.dart';
import 'package:notes_project/UI/home/controller/HomeController.dart';
import 'package:notes_project/UI/notes/controller/NoteController.dart';
import 'package:notes_project/data/local%20/preferences/old_images_key.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/helper/db_helper.dart';
import 'package:internet_connectivity_checker/internet_connectivity_checker.dart';
import 'package:notes_project/UI/home/widget/homeAppBarWidget.dart';
import 'package:notes_project/UI/home/widget/homeHeaderWidget.dart';
import 'package:notes_project/UI/home/widget/homeNoteListWidget.dart';
import 'package:notes_project/main.dart';
import '../../blocs/blocs.dart';
import 'dart:developer';
import 'dart:async';

import '../../constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final NoteBloc noteBloc = locator.Get<NoteBloc>();
  final DBHelper _db = DBHelper.instance;
  late StreamSubscription subscription;

  @override
  void initState() {
    _db.database();
    noteBloc.eventSink.add(RestoreNoteFiles());
    super.initState();
    subscription = ConnectivityChecker().stream.listen(showConnectionSnackBar);
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
            SliverList(delegate: SliverChildListDelegate([])),
          ]),
    );
  }

  void showConnectionSnackBar(var result) async {
    final hasInternet = result;
    TIME_OUT = !hasInternet ? TIME_OUT + 1 : 0;
    if (hasInternet) {
      List<String>? imagesFromPref =
          await locator.Get<OldImagesPrefService>().oldImages;
      if (imagesFromPref != null) {
        await locator.Get<NoteController>()
            .deleteImageFromCloud(images: imagesFromPref);
        locator.Get<OldImagesPrefService>().removeAllOldImages;
      }
    }
    locator.Get<HomeController>().showSnackbarMessage(
        context: context, TIME_OUT: TIME_OUT, hasInternet: hasInternet);
  }
}
