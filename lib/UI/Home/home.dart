import 'package:flutter/material.dart';
import 'package:notes_project/Widgets/popupOptions.dart';
import 'package:notes_project/UI/notes/CreateNote.dart';
import 'package:notes_project/Widgets/NoteView.dart';
import '../../Widgets/DialogSearch.dart';
import '../../data/local/NotesRepository.dart';
import '../../domain/entities/Note.dart';

// ignore: must_be_immutable
class notesPage extends StatefulWidget {
  notesPage(
    {
    super.key,
  });

  @override
  State<notesPage> createState() => _notesPageState();
}

class _notesPageState extends State<notesPage> {
  late List<note> _listNote;

  @override
  void initState() {
    //todo metodo que necesitemos que se cargue apenas iniciar, lo pondremos dentro de este metodo
    super.initState();
    _listNote = NoteRepository.getList("");
  }

  @override
  void dispose() {
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
              await Navigator.push(context, MaterialPageRoute(builder: (context) => createNote()));
              setState(() { });
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
      body: SafeArea(//Esto es para los teléfonos con Notch
        child: Container(
          height: double.infinity,
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: _listNote.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return noteCard(_listNote, index);
            },
          ),
        ),
      ),
    );
  }
}
