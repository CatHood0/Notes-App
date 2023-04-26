import 'package:flutter/material.dart';
import 'package:notes_project/UI/home/widget/view_home_page_widget.dart';
import 'package:notes_project/Widgets/snackMessage.dart';
import 'package:notes_project/domain/bloc/users/UserBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/main.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final NoteBloc noteBloc = blocInject.getBloc<NoteBloc>();
  final UserBloc userBloc = blocInject.getBloc<UserBloc>();
  bool hadConnectionBefore = false;
  late StreamSubscription subscription;
  @override
  void initState() {
    noteBloc.eventSink.add(RestoreNoteFiles());
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectionSnackBar);
  }

  @override
  void dispose() {
    noteBloc.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabBar = TabController(length: 2, vsync: this);
    DateTime now = DateTime.now();
    return Scaffold(body: ViewHomePageWidget(now: now, tabBar: tabBar));
  }

  void showConnectionSnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    String message = "";
    Color color = Colors.grey;
    if (hasInternet) {
      message = 'Connection restaured. Synchronization changes';
      color = Colors.lightGreen;
      if (hadConnectionBefore) {
        SnackMessage.showSnackbarMessage(
          context: context,
          message: message,
          backgroudColor: color,
        );
      }
    } else {
      hadConnectionBefore = true;
      message =
          'Please, check your connection. The changes will not be apply if you dont have a connection';
      color = Colors.red;
      SnackMessage.showSnackbarMessage(
        context: context,
        message: message,
        textColor: Colors.white,
        duration: const Duration(days: 1000000),
        backgroudColor: color,
      );
    }
  }
}
