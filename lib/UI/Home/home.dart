import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_project/UI/notes/CreateNote.dart';
import 'package:notes_project/Widgets/popupOptions.dart';
import 'package:notes_project/Widgets/NoteView.dart';
import 'package:notes_project/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/bloc/Notes/NoteStates.dart';
import '../../Widgets/DialogSearch.dart';

class notesPage extends ConsumerStatefulWidget {
  notesPage({
    super.key,
  });

  @override
  ConsumerState<notesPage> createState() => _notesPageState();
}

class _notesPageState extends ConsumerState<notesPage> {
  final NoteBloc bloc = NoteBloc();
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
      backgroundColor: Color.fromARGB(255, 58, 58, 58),
      appBar: AppBar(
        title: Text('Koulin spaces',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 59, 59, 59),
        elevation: 8,
        leading: popupMenu(),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            splashRadius: 20,
            tooltip: "Add a new note",
            color: Color.fromARGB(255, 255, 255, 255),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => createNote(bloc: bloc)));
            },
          ),
          IconButton(
            alignment: Alignment.centerRight,
            tooltip: "Search",
            icon: Icon(Icons.search),
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
        child: Container(
          height: double.infinity,
          child: StreamBuilder<NoteState>(
            stream: bloc.stateStream,
            builder: (context, snapshot) {
              if (snapshot.data is LoadedNotes) {
                final data = (snapshot.data as LoadedNotes).notes;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: data.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return noteCard(data[index], index, bloc: bloc,);
                  },
                );
              } else if (snapshot.data is LoadingNotes) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data is NoteNotFound) {}
              return Center(
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
