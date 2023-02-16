import 'package:flutter/material.dart';
import 'package:notes_project/controller/NoteController.dart';
import 'package:notes_project/view/Menu.dart';
import 'package:notes_project/view/ReadNote.dart';
import '../model/Note.dart';

class homePage extends StatefulWidget {
  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  
  List<note> listaNotas = noteController.getList();
  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 58, 58, 58),
        appBar: AppBar(
          title:  Text('Koulin spaces', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 59, 59, 59),
          elevation: 8,
          actions: [
          IconButton(
            icon: Icon(Icons.add),
            splashRadius: 20,
            color: Color.fromARGB(255, 255, 255, 255),
              onPressed: (){
                Navigator.pushNamed(context, 'create_notes');
                setState(() {
                   
                });
              },
          ),
            IconButton(
              alignment: Alignment.centerRight,
              tooltip: "Search",
              onPressed: () {
              }, 
              icon: const Icon(Icons.search)
              ),
          ],
        ),
        body: Container(
             height: double.infinity,
                child: ListView.builder(
                  itemCount: listaNotas.length,
                  itemBuilder: (context, index) {
                    return Container(
                       child: GestureDetector(
                        onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => readPage(new note(listaNotas[index].getTitle(), listaNotas[index].getContent(), listaNotas[index].getDate(), listaNotas[index].getId()))));
                        },
                         child: Card(
                          color: Colors.grey,
                              child: Column(
                                children: [
                                   Text(listaNotas[index].getTitle(), style: TextStyle(color: Colors.white),),
                                ],
                              ),
                           ),
                       ),
                      );              
                    },    
                  ), 
        ),
                
        drawer: Container(
          width: 200,
          child: menu(context),
          
        ),
    );
  }


}