import 'package:flutter/material.dart';
import 'package:notes_project/Widgets/CustomCard.dart';
import 'package:notes_project/controller/CreateNoteController.dart';
import 'package:notes_project/model/Note.dart';

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
      backgroundColor:  Color.fromARGB(255, 58, 58, 58),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 59, 59, 59),
        elevation: 8,
        title: Text("New note", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 5,
            ),
            child: Row(
              children: [
                Container(
                 child:  IconButton(
                    splashRadius: 20,
                    icon: Icon(Icons.check),
                    onPressed: () {
                      final Note = new customCard(2, title, content, DateTime.now());
                      setState(() {
                      noteController.listaNotas.insert(0, Note);
                      print(noteController.listaNotas.length);
                      Navigator.pushReplacementNamed(context, 'homePage');
                        
                      });
                    },
                 ),
                ),
                Container(
                  child:  IconButton(
                    splashRadius: 20,
                    icon: Icon(Icons.clear),
                    onPressed: () {
                        Navigator.pushReplacementNamed(context, 'homePage');
                    },
                 ),
                ),
              ],
            ),
          ),
        ],
      ),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 5
                    ),
                    child: Container(
                      child: Text("Title", style: TextStyle(fontSize: 20,color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 7,
                      left: 7,
                    ),
                    child: Container(
                      height: 21,
                      width: double.infinity,
                      child: TextFormField(
                          autocorrect: true,
                          controller: textTitleController,
                          autofocus: false,
                          decoration: InputDecoration(hintText: "Your title", hintStyle: TextStyle(color: Colors.grey)),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          onChanged: (value) => {title = value, print(title),},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        child: TextFormField(
                            autocorrect: true,
                            controller: textContentController,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            decoration: InputDecoration.collapsed(
                                hintText: "Write your thoughts", hintStyle: TextStyle(color: Colors.grey),
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