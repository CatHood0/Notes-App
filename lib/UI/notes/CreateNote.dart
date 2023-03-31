import 'package:flutter/material.dart';
import 'package:notes_project/data/local/NotesRepository.dart';
import '../../domain/entities/Note.dart';

class createNote extends StatefulWidget {
  createNote({super.key});

  @override
  State<createNote> createState() => _createNoteState();
}

class _createNoteState extends State<createNote> {
  late TextEditingController textTitleController;
  late TextEditingController textContentController;
  String title = "";
  String content = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 58, 58, 58),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 59, 59, 59),
        elevation: 8,
        title: Text("New note",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: IconButton(
                  splashRadius: 20,
                  icon: Icon(Icons.check),
                  onPressed: () {
                    final Note = new note(title: title, content: content, createDate: DateTime.now(), key: 2,
                        favorite: false, dateTimeModification: DateTime.now());
                        NoteRepository.addCustomCard(Note);
                        Navigator.pop(context);
                    setState(() {});
                  },
                ),
              ),
              Container(
                child: IconButton(
                  splashRadius: 20,
                  icon: Icon(Icons.clear),
                  onPressed: () {
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 2,
                  right: 7,
                  left: 7,
                ),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    autocorrect: true,
                    controller: textTitleController,
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: "Your title",
                        hintStyle: TextStyle(color: Colors.grey)),
                    style: TextStyle(color: Colors.white, fontSize: 22),
                    onChanged: (value) => {title = value},
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    autocorrect: true,
                    controller: textContentController,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration.collapsed(
                      hintText: "Write your thoughts",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (value) => {content = value},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    textContentController = TextEditingController();
    textTitleController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textContentController.dispose();
    textTitleController.dispose();
  }
}
