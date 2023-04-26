import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:notes_project/Widgets/snackMessage.dart';
import 'package:notes_project/main.dart';
import 'package:notes_project/UI/home/widget/view_home_page_widget.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final NoteBloc bloc = blocInject.getBloc<NoteBloc>();
  bool hadConnectionBefore = false;
  late StreamSubscription subscription;
  @override
  void initState() {
    bloc.eventSink.add(RestoreNoteFiles());
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectionSnackBar);
  }

  @override
  void dispose() {
    bloc.dispose();
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
      message = 'you have a internet. Synchronizing data';
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
          'Please, check your connection. The changes will be apply when you are connected to some devide with internet';
      color = Colors.red;
      SnackMessage.showSnackbarMessage(
        context: context,
        message: message,
        backgroudColor: color,
      );
    }
  }
}
