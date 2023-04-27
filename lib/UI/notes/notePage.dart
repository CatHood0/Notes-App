import 'package:flutter/material.dart';
import 'package:notes_project/UI/notes/screens/DetailPage.dart';
import 'package:notes_project/UI/notes/widget/listNoteWidget.dart';
import 'package:notes_project/UI/notes/widget/popupOptions.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/main.dart';
import '../../blocs(Exports)/blocs.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({
    super.key,
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final noteBloc = blocInject.getBloc<NoteBloc>();
  final _searchController = TextEditingController(text: "");
  bool searchMode = false, userMostSearch = false;
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
        if (quitCount > 1 && searchMode) {
          isSearcheable(searcheable: false);
          if (userMostSearch) {
            noteBloc.eventSink.add(SearchNote(search: ""));
          }
          return false;
        } else if (!searchMode) {
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
                        ),
                  elevation: 0,
                  leading: const PopupMenu(),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      splashRadius: 20,
                      tooltip: "Add a new note",
                      color: const Color.fromARGB(255, 255, 255, 255),
                      onPressed: () async {
                        _searchController.clear();
                        isSearcheable(searcheable: false);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DetailPage(
                                      null,
                                      null,
                                      edit: true,
                                    )));
                      },
                    ),
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
                          _searchController.clear();
                          isSearcheable(searcheable: false);
                        }
                      },
                    ),
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
