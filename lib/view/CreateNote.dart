import 'package:flutter/material.dart';

class createNote extends StatefulWidget {
  createNote({super.key});

  @override
  State<createNote> createState() => _createNoteState();
}

class _createNoteState extends State<createNote> {
  late TextEditingController textTitleController;
  late TextEditingController textContentController; 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 59, 59, 59),
        elevation: 8,
        title: Text("New note", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 20,
            ),
            child: Container(
             child:  IconButton(
                splashRadius: 20,
                icon: Icon(Icons.delete),
                onPressed: () {},
             ),
            ),
          ),
        ],
      ),
        body: Container(
          height: double.infinity,
          color:  Color.fromARGB(255, 58, 58, 58),
          child: Stack(
            children: <Widget>[
                Container(
                  child: Text("Hola", style: TextStyle()),
                ),
                Container(

                ),
                Container(),
              
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