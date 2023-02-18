import 'package:flutter/material.dart';
import 'package:notes_project/controller/NoteController.dart';
import 'package:notes_project/view/DialogSearch.dart';
import 'package:notes_project/view/Menu.dart';
import 'package:notes_project/view/ReadNote.dart';
import '../model/Note.dart';

// ignore: must_be_immutable
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
                  showDialog(context: context, builder: (context){
                       return dialogSearch();
                    },
                  );
                }, 
              ),
          ],
        ),
        body: Container(
             height: double.infinity,
                child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
                itemCount: listaNotas.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                      return Container(                       
                          height: 70,
                           child: GestureDetector(
                            onTap: () {
                              final Note = new note(listaNotas[index].getTitle(), listaNotas[index].getContent(), listaNotas[index].getDate(), listaNotas[index].getId(), listaNotas[index].getFavorite());
                              Navigator.push(context, MaterialPageRoute(builder: (context) => readPage(index, Note)));
                              print(index);
                            },               
                             child: Padding(
                               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                 child: Card(
                                  elevation: 10,
                                  color: Color.fromARGB(255, 105, 105, 105),
                                      child: Column(                              
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 120,
                                              bottom: 9,
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                              setState(() {
                                              listaNotas[index].getFavorite() ?
                                              noteController.setFavorite(index, false)
                                              :
                                              noteController.setFavorite(index, true);
                                              });
                                            }, 
                                            icon: listaNotas[index].getFavorite() ? 
                                            Icon(Icons.star, color: Color.fromARGB(255, 240, 153, 255),)
                                            :
                                            Icon(Icons.star_outline, color: Color.fromARGB(255, 240, 153, 255),),
                                            splashRadius: 20,
                                            alignment: Alignment.center,
                                            tooltip: "Select star for convert this note in your favorite",
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10,
                                              right: 8,
                                              left: 8,
                                            ),
                                            child: Text(listaNotas[index].getTitle(), style: 
                                                TextStyle(color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20
                                                ),
                                                
                                            ),
                                          ),               
                                        ],
                                      ),
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