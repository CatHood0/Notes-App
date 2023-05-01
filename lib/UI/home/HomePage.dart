import 'package:flutter/material.dart';
import 'package:notes_project/UI/home/widget/homeAppBarWidget.dart';
import 'package:notes_project/UI/home/widget/homeHeaderWidget.dart';
import 'package:notes_project/UI/home/widget/homeNoteListWidget.dart';
import 'package:notes_project/Widgets/snackMessage.dart';
import 'package:notes_project/db%20helper/db_helper.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/domain/bloc/Store/StoreEvents.dart';
import 'package:notes_project/main.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../blocs/blocs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final NoteBloc noteBloc = locator.Get<NoteBloc>();
  final StoreBloc storeBloc = locator.Get<StoreBloc>();
  bool hadConnectionBefore = false;
  final DBHelper _db = DBHelper.instance;
  late StreamSubscription subscription;

  @override
  void initState() {
    _db.database();
    noteBloc.eventSink.add(RestoreNoteFiles());
    storeBloc.eventSink.add(RestoreAllTemplates());
    storeBloc.eventSink.add(RecommendTemplateEvent());
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectionSnackBar);
  }

  @override
  void dispose() {
    _db.closeDb();
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
            SliverToBoxAdapter(child: Text("Task")),
          ]),
    );
  }

  void showConnectionSnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    String message = "";
    Color color = Colors.grey;
    if (hasInternet && hadConnectionBefore) {
      message = 'Connection restaured. We will go to synchronize any change';
      color = Colors.lightGreen;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      SnackMessage.showSnackbarMessage(
        context: context,
        message: message,
        backgroudColor: color,
      );
    } else if (!hasInternet && result != ConnectivityResult.bluetooth) {
      hadConnectionBefore = true;
      message =
          'Please, check your connection. The changes will not be apply if you dont have a connection';
      color = Colors.red;
      SnackMessage.showSnackbarMessage(
        context: context,
        message: message,
        duration: const Duration(days: 1000000),
        backgroudColor: color,
      );
    }
  }
}
