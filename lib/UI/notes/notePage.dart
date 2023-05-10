import 'package:flutter/material.dart';
import 'package:notes_project/UI/notes/screens/DetailPage.dart';
import 'package:notes_project/UI/notes/widget/listNoteWidget.dart';
import 'package:notes_project/blocs/blocs.dart';
import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/main.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({
    super.key,
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NoteBloc noteBloc = locator.Get<NoteBloc>();
  final _searchController = TextEditingController(text: "");
  bool searchMode = false,
      userMostSearch = false; //when the user is in the search page
  int quitCount = 0;

  void isSearcheable({required bool searcheable}) {
    setState(() {
      searchMode = searcheable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (quitCount > 0 && searchMode || userMostSearch) {
          isSearcheable(searcheable: false);
          if (userMostSearch) {
            userMostSearch = false;
            locator.Get<NoteBloc>().eventSink.add(SearchNote(search: ""));
          }
          return false;
        } else if (!searchMode || !userMostSearch) {
          quitCount = 0;
          return true;
        }
        quitCount++;
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.080),
          child: StreamBuilder<int>(
              initialData: 0,
              stream: noteBloc.stateLenghtStream,
              builder: (context, snapshot) {
                return AppBar(
                  title: !searchMode
                      ? Text('Notes (${snapshot.data})',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white))
                      : TextFormField(
                          autocorrect: true,
                          controller: _searchController,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            hintText: "Example: cookies",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          onChanged: (value) {
                            searchMode = true;
                          },
                        ),
                  elevation: 0,
                  actions: [
                    IconButton(
                      alignment: Alignment.centerRight,
                      tooltip: "Search",
                      icon: const Icon(Icons.search),
                      splashRadius: 20,
                      onPressed: () {
                        if (!searchMode) {
                          isSearcheable(searcheable: true);
                        } else {
                          noteBloc.eventSink
                              .add(SearchNote(search: _searchController.text));
                          userMostSearch = true;
                          isSearcheable(searcheable: false);
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        _searchController.clear();
                        isSearcheable(searcheable: false);
                        userMostSearch = false;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DetailPage(
                                      null,
                                      null,
                                      edit: true,
                                    )));
                      },
                      icon: Icon(Icons.add),
                    )
                  ],
                );
              }),
        ),
        body: SafeArea(
          child: ListNotesBlocWidget(),
        ),
      ),
    );
  }
}
