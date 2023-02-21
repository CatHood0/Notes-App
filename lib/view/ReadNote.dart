import 'package:flutter/material.dart';
import 'package:notes_project/Widgets/DialogProperties.dart';
import 'package:notes_project/view/EditNote.dart';

import '../model/Note.dart';

// ignore: must_be_immutable
class readPage extends StatefulWidget {
  note Note;
  int index;
  readPage(this.index, this.Note, {super.key});

  @override
  State<readPage> createState() => _readPageState();
}

class _readPageState extends State<readPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 58, 58, 58),
        appBar: AppBar(
          title: Text(widget.Note.getTitle(), style: 
          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          elevation: 5,
          backgroundColor: Color.fromARGB(255, 59, 59, 59),
          actions: [
            IconButton(
                onPressed: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => editNote(widget.index, widget.Note)));
                    setState(() {});
                }, 
                icon: Icon(Icons.edit)
              ),
            IconButton(
              onPressed: () {
                 showDialog(context: context, builder: (context){
                       return propertiesNote(widget.Note);
                    },
                  );
              },
              icon: Icon(Icons.insert_drive_file),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
                  Container(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextFormField(
                          minLines: 1,
                          enabled: false,
                          decoration: InputDecoration.collapsed(hintText: 'Empty note', hintStyle: TextStyle(color: Colors.white, fontSize: 18)),
                          initialValue: widget.Note.getContent(), style: TextStyle(color: Colors.white, fontSize: 18),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                        ),
                      ),
                  ),
              ],
          ),
        ),     
    );
  }
}