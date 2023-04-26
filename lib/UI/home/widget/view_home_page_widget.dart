import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_project/main.dart';
import 'package:notes_project/constant.dart';
import '../../../enums.dart';
import '../../notes/notePage.dart';
import '../../../Widgets/note_card.dart';
import '../../notes/widget/listNoteWidget.dart';
import '../../../domain/bloc/Notes/NoteBloc.dart';
import '../../../domain/bloc/Notes/NoteStates.dart';
import '../../../domain/bloc/Notes/NoteEvents.dart';

class ViewHomePageWidget extends StatelessWidget {
  ViewHomePageWidget({
    super.key,
    required this.now,
    required this.tabBar,
  });

  final DateTime now;
  final TabController tabBar;
  final bloc = blocInject.getBloc<NoteBloc>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                "¡Good evening Santiago! \n  ${DateFormat.yMMMMd().format(now)}",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              )),
          backgroundColor: Colors.black,
          elevation: 5,
          title: const Text("Home"),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const ButtonNotesWidget(),
              TabBar(
                  onTap: (value) {
                    if (value == 0) {
                      bloc.eventSink
                          .add(SortNotesEvents(sort: TypeSort.title));
                    } else {}
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
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: StreamBuilder<NoteState>(
                stream: bloc.stateStream,
                builder: (context, snapshot) {
                  if (snapshot.data is LoadedNotes) {
                    final data = (snapshot.data as LoadedNotes).notes;
                    return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: ScrollController(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: NoteCard(
                              data[index],
                              index,
                              isHomePage: true,
                            ),
                          );
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
                    textAlign: TextAlign.justify,
                  ));
                }),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Text(
              "Template recommends for you",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NotesPage()));
        },
        icon: const Icon(Icons.arrow_forward),
        label: const Text(
          "Notes",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        style: const ButtonStyle(animationDuration: Duration(seconds: 1)),
      ),
    );
  }
}
