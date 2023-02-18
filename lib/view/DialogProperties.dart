import 'package:flutter/material.dart';
import '../model/Note.dart';

class propertiesNote extends StatefulWidget {
  note Note;
  propertiesNote(this.Note, {super.key});

  @override
  State<propertiesNote> createState() => _propertiesNoteState();
}

class _propertiesNoteState extends State<propertiesNote> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Color.fromARGB(255, 78, 78, 78),
        child: Container(
            height: 200,
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Text('Title: ${widget.Note.getTitle()}'),
                  Text('Date: ${widget.Note.getDate().toString()}'),
                  Text('Modification: ${widget.Note.getDateModification().toString()}'),
                  Text('id: ${widget.Note.getId().toString()}'),
              ]
            ),
        ),
    );
  }
}