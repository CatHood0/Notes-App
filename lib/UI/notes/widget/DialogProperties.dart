import 'package:flutter/material.dart';
import '../../../domain/entities/Note.dart';

class PropertiesNote extends StatefulWidget {
  final Note? currentNote;
  const PropertiesNote({super.key, required this.currentNote});

  @override
  State<PropertiesNote> createState() => _PropertiesNoteState();
}

class _PropertiesNoteState extends State<PropertiesNote> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: const Color.fromARGB(255, 78, 78, 78),
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Text('Title: ${widget.currentNote!.title}'),
                  Text('Date: ${widget.currentNote!.createDate.toString()}'),
                  Text('Modification: ${widget.currentNote!.dateTimeModification.toString()}'),
                  Text('id: ${widget.currentNote!.key.toString()}'),
              ]
            ),
        ),
    );
  }
}