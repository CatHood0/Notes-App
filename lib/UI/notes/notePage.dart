import 'package:flutter/material.dart';
import 'package:notes_project/UI/notes/screens/DetailPage.dart';
import 'package:notes_project/UI/notes/widget/listNoteWidget.dart';
import 'package:notes_project/Widgets/popupOptions.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({
    super.key,
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late final _searchController = TextEditingController(text: "");
  bool searchMode = false, userMostSearch = false;
  int quitCount = 0;

  void isSearcheable({required bool searcheable}) {
    setState(() {
      searchMode = searcheable;
    });
  }

  @override
  void initState() {
    bloc.eventSink.add(RestoreNoteFiles());
    //we do begin for the user has a list of notes
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (quitCount > 1 && searchMode) {
          isSearcheable(searcheable: false);
          if (userMostSearch) {
            bloc.eventSink.add(SearchNote(search: ""));
          }
          return false;
        } else if (!searchMode) {
          return true;
        }
        quitCount++;
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: !searchMode
              ? const Text('Koulin spaces',
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
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 59, 59, 59),
          elevation: 8,
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
                  bloc.eventSink
                      .add(SearchNote(search: _searchController.text));
                  userMostSearch = true;
                  _searchController.clear();
                  isSearcheable(searcheable: false);
                }
              },
            ),
          ],
        ),
        body: const SafeArea(
          child: ListNotesBlocWidget(),
        ),
      ),
    );
  }
}
