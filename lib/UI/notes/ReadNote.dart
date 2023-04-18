import 'package:flutter/material.dart';
import 'package:notes_project/Widgets/DialogProperties.dart';
import 'package:notes_project/UI/notes/EditNote.dart';
import 'package:notes_project/bloc/Notes/NoteBloc.dart';
import '../../domain/entities/Note.dart';

class readPage extends StatefulWidget {
  final note Note;
  final int index;
  final NoteBloc bloc; 
  const readPage(this.index, this.Note, {super.key, required this.bloc});

  @override
  State<readPage> createState() => _readPageState();
}

class _readPageState extends State<readPage> {
  late note Note;
  @override
  void initState() {
    Note = widget.Note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 58, 58, 58),
        appBar: AppBar(
          title: Text(Note.Title, style: 
          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          elevation: 5,
          backgroundColor: Color.fromARGB(255, 59, 59, 59),
          actions: [
            IconButton(
                onPressed: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => editNote(widget.index, widget.Note, bloc: widget.bloc,)));
                    Note = widget.bloc.getNote(id: widget.Note.key); 
                    setState(() {});
                }, 
                icon: Icon(Icons.edit)
              ),
            IconButton(
              onPressed: () {
                 showDialog(context: context, builder: (context){
                       return propertiesNote(Note);
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
                          initialValue: Note.Content, style: TextStyle(color: Colors.white, fontSize: 18),
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