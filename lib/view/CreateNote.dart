import 'package:flutter/material.dart';
import 'package:notes_project/controller/NoteController.dart';
import 'package:notes_project/view/Pages.dart';

import '../model/Note.dart';

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
                    final Note =
                        new note(title, content, DateTime.now(), 2, false, DateTime.now());
                    setState(() {
                      noteController.addCustomCard(Note);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => pages()),
                          (Route<dynamic> route) => false);
                    });
                  },
                ),
              ),
              Container(
                child: IconButton(
                  splashRadius: 20,
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => pages()),
                        (Route<dynamic> route) => false);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
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
