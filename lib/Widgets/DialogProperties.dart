import 'package:flutter/material.dart';
import '../domain/entities/Note.dart';

// ignore: must_be_immutable
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
                  Text('Title: ${widget.Note.title}'),
                  Text('Date: ${widget.Note.createDate.toString()}'),
                  Text('Modification: ${widget.Note.dateTimeModification.toString()}'),
                  Text('id: ${widget.Note.key.toString()}'),
              ]
            ),
        ),
    );
  }
}