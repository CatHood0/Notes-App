import 'package:flutter/material.dart';
import 'package:notes_project/UI/home/controller/HomeController.dart';
import 'package:notes_project/UI/notes/controller/NoteController.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/helper/db_helper.dart';
import 'package:internet_connectivity_checker/internet_connectivity_checker.dart';
import 'package:notes_project/UI/home/widget/homeAppBarWidget.dart';
import 'package:notes_project/UI/home/widget/homeHeaderWidget.dart';
import 'package:notes_project/UI/home/widget/homeNoteListWidget.dart';
import 'package:notes_project/main.dart';
import '../../blocs/blocs.dart';
import 'dart:async';
import '../../constant.dart';
import '../../domain/entities/check.dart';

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
    locator.Get<CheckBloc>().eventSink.add(RestoreAllCheckEvent());
    super.initState();
    subscription = ConnectivityChecker().stream.listen(showConnectionSnackBar);
  }

  @override
  void dispose() {
    _db.closeDatabase();
    locator.Get<NoteController>().closeLocalDatabase();
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
                    "Checks list",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            HomeCheckListWidget()
          ]),
    );
  }

  void showConnectionSnackBar(var result) async {
    final hasInternet = result;
    TIME_OUT = !hasInternet ? TIME_OUT + 1 : 0;
    locator.Get<HomeController>().showSnackbarMessage(
        context: context, TIME_OUT: TIME_OUT, hasInternet: hasInternet);
  }
}

class HomeCheckListWidget extends StatelessWidget {
  const HomeCheckListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: StreamBuilder<CheckState>(
          stream: locator.Get<CheckBloc>().stream,
          builder: (context, state) {
            if (state.data is CheckLoadedState) {
              final data = (state.data as CheckLoadedState).tasks;
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final check = data[index];
                    return CheckWidget(
                      check: check,
                      index: index,
                    );
                  });
            }
            if (state.data is CheckLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Text("Something is wrong"),
              );
            }
          },
        ),
      ),
    );
  }
}

class CheckWidget extends StatelessWidget {
  const CheckWidget({
    super.key,
    required this.check,
    required this.index,
  });

  final Check check;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Card(
        color: default_color_card,
        margin: null,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {},
          child: CheckContentCardWidget(check: check),
        ),
      ),
    );
  }
}

class CheckContentCardWidget extends StatelessWidget {
  const CheckContentCardWidget({
    super.key,
    required this.check,
  });

  final Check check;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CheckTitleWidget(check: check),
            CompleteAllChecksWidget(),
          ],
        ),
        CheckReadableContentWidget(check: check),
        Container(

        ),
      ],
    );
  }
}

class CheckReadableContentWidget extends StatelessWidget {
  const CheckReadableContentWidget({
    super.key,
    required this.check,
  });

  final Check check;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: Text(check.readeable),
    );
  }
}

class CompleteAllChecksWidget extends StatelessWidget {
  const CompleteAllChecksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        tooltip: "¡Complete all tasks!",
        splashRadius: 25,
        color: secundaryColor,
        onPressed: () {},
        icon: Icon(Icons.check),
      ),
    );
  }
}

class CheckTitleWidget extends StatelessWidget {
  const CheckTitleWidget({
    super.key,
    required this.check,
  });

  final Check check;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        check.name,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
