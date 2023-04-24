import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:notes_project/UI/notes/notePage.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/domain/bloc/Notes/NoteStates.dart';
import 'package:notes_project/main.dart';
import '../../Widgets/NoteView.dart';
import '../notes/widget/listNoteWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final NoteBloc bloc = blocInject.getBloc<NoteBloc>();

  @override
  void initState() {
    bloc.eventSink.add(RestoreNoteFiles());
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
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
          SliverAppBar.large(
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.20,
            flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1553095066-5014bc7b7f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2FsbCUyMGJhY2tncm91bmR8ZW58MHx8MHx8&w=1000&q=80",
                  fit: BoxFit.cover,
                ),
                titlePadding:
                    const EdgeInsets.only(right: 10, left: 20, bottom: 30),
                title: Text(
                  "Good evening {username} \n  ${DateFormat.yMMMMd().format(now)}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                )),
            backgroundColor: Colors.black,
            elevation: 5,
            title: Text("Home"),
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            ButtonNotesWidget(),
            TabBar(
                onTap: (value) {
                  if (value == 0) {
                    bloc.eventSink
                        .add(SortNotesEvents(notes: bloc.getAllNotes()));
                  } else {}
                },
                controller: tabBar,
                tabs: [
                  Tab(
                    text: "Recent",
                  ),
                  Tab(text: "Suggested")
                ]),
            Container(
              height: 200,
              child: StreamBuilder(
                  stream: bloc.stateStream,
                  builder: (context, snapshot) {
                    if (snapshot.data is LoadedNotes) {
                      final data = (snapshot.data as LoadedNotes).notes;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return;
                          });
                    } else if (snapshot.data is LoadingNotes) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.data is NoteNotFound) {
                      final error = (snapshot.data as NoteNotFound).onError;
                      return ErrorMessageWidget(error: error);
                    }
                    return const Center(
                        child: Text(
                      '¡Ops!, may that the service is not working',
                      style: TextStyle(color: Colors.white),
                    ));
                  }),
            )
          ])),
        ],
      ),
    );
  }
}

class ButtonNotesWidget extends StatelessWidget {
  const ButtonNotesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      alignment: Alignment.centerLeft,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NotesPage()));
        },
        icon: Icon(Icons.arrow_forward),
        label: Text(
          "Notes",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        style: ButtonStyle(animationDuration: Duration(seconds: 1)),
      ),
    );
  }
}
