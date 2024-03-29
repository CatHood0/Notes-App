import 'package:flutter/material.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/main.dart';
import '../../../Widgets/buttonWidget.dart';
import '../../../constant.dart';
import '../../../domain/bloc/Notes/NoteEvents.dart';
import '../../../domain/enums/enums.dart';
import '../../notes/notePage.dart';

class HomeHeaderWidget extends StatelessWidget {
  HomeHeaderWidget({
    super.key,
    required this.tabBar,
  });

  final TabController tabBar;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            alignment: Alignment.centerLeft,
            child: ButtonNotesWidget(
              buttonStyle: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(primaryColor),
                  animationDuration: Duration(seconds: 1)),
              message: 'Notes',
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NotesPage()));
                tabBar.index = 0;
              },
              textStyle: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
          TabBar(
              onTap: (value) {
                locator.Get<NoteBloc>().eventSink.add(SortNotesEvents(
                    sort: value == 0 ? TypeSort.recent : TypeSort.suggested));
              },
              controller: tabBar,
              tabs: const <Widget>[
                Tab(
                  text: "Recent",
                ),
                Tab(text: "Suggested")
              ]),
        ],
      ),
    );
  }
}
