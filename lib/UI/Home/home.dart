import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_project/UI/notes/CreateNote.dart';
import 'package:notes_project/Widgets/popupOptions.dart';
import 'package:notes_project/Widgets/NoteView.dart';
import '../../Widgets/DialogSearch.dart';
import '../../domain/provider/noteNProvider.dart';

class notesPage extends ConsumerStatefulWidget {
  notesPage({
    super.key,
  });

  @override
  ConsumerState<notesPage> createState() => _notesPageState();
}

class _notesPageState extends ConsumerState<notesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = ref.watch(noteNotifierProvider);
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => createNote()));
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
        //Esto es para los teléfonos con Notch
        child: Container(
          height: double.infinity,
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: n.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return noteCard(n, index);
            },
          ),
        ),
      ),
    );
  }
}
