// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_project/UI/notes/screens/DetailPage.dart';
import 'package:notes_project/Widgets/popupOptions.dart';
import 'package:notes_project/Widgets/NoteView.dart';
import 'package:notes_project/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/bloc/Notes/NoteStates.dart';
import '../../Widgets/DialogSearch.dart';

class NotesPage extends ConsumerStatefulWidget {
  const NotesPage({
    super.key,
  });

  @override
  ConsumerState<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends ConsumerState<NotesPage> {
   @override
  void initState() {
    bloc.eventSink
       .add(RestoreNoteFiles()); //we do begin for the user has a list of notes
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 58, 58, 58),
      appBar: AppBar(
        title: const Text('Koulin spaces',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 59, 59, 59),
        elevation: 8,
        leading: popupMenu(),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            splashRadius: 20,
            tooltip: "Add a new note",
            color: const Color.fromARGB(255, 255, 255, 255),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DetailPage(null, null, edit: true,)));
            },
          ),
          IconButton(
            alignment: Alignment.centerRight,
            tooltip: "Search",
            icon: const Icon(Icons.search),
            splashRadius: 20,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return dialogSearch();
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        //This must change for a StreamBuilder and use it with a bloc we do create up
        child: SizedBox(
          height: double.infinity,
          child: StreamBuilder<NoteState>(
            stream: bloc.stateStream,
            builder: (context, snapshot) {
              if (snapshot.data is LoadedNotes) {
                final data = (snapshot.data as LoadedNotes).notes;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: data.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                      return NoteCard(data[index], index);
                  },
                );
              } else if (snapshot.data is LoadingNotes) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data is NoteNotFound) {}
              return const Center(
                  child: Text(
                "Notes not found",
                style: TextStyle(color: Colors.white),
              ));
            },
          ),
        ),
      ),
    );
  }
}
