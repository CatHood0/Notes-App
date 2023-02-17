import 'package:flutter/material.dart';
import 'package:notes_project/controller/NoteController.dart';
import 'package:notes_project/view/Menu.dart';
import 'package:notes_project/view/ReadNote.dart';
import '../model/Note.dart';

class homePage extends StatefulWidget {
  String? search;
  homePage(this.search,{super.key,});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  
  late List<note> listaNotas;
  late bool isSearcheable;

  @override
  void initState() {//todo metodo que necesitemos que se cargue apenas iniciar, lo pondremos dentro de este metodo
    super.initState();
    listaNotas = noteController.getList(widget.search);
    isSearcheable = noteController.isSearch(widget.search);
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
            tooltip: "Add a new note",
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
              icon: Icon(Icons.search),
              onPressed: () {

                }, 
              ),

          ],
        ),
        body: Container(
             height: double.infinity,
             child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
              itemCount: listaNotas.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                    return Container(
                      height: 70,
                       child: GestureDetector(
                        onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => readPage(new note(listaNotas[index].getTitle(), listaNotas[index].getContent(), listaNotas[index].getDate(), listaNotas[index].getId()))));
                        },
                         child: Card(
                          shadowColor: Colors.purpleAccent,
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