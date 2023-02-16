import 'package:flutter/material.dart';

import '../model/Note.dart';

// ignore: must_be_immutable
class readPage extends StatefulWidget {
  note Note;
  readPage(this.Note, {super.key});

  @override
  State<readPage> createState() => _readPageState();
}

class _readPageState extends State<readPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.Note.getTitle()),
        ),
        body:  Center(
          child: Text(widget.Note.getContent(), softWrap: true, maxLines: null,),
        ),
    );
  }
}