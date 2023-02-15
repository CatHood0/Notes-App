import 'package:flutter/material.dart';
import 'package:notes_project/model/Note.dart';
import 'package:notes_project/view/Menu.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

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
              alignment: Alignment.centerRight,
              tooltip: "Search",
              onPressed: () {
                
              }, 
              icon: const Icon(Icons.search)
              ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 50,
                right: 10,
                top: 10,
              ),
              child: Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: Color.fromARGB(255, 133, 133, 133),
                      elevation: 5,
                      shape: CircleBorder(),
                      onPressed: (){
                          Navigator.pushNamed(context, 'create_notes');
                      },
                    ),
                  ],
                ),  
              ),
            ),
          ],
        ),
        drawer: Container(
          width: 200,
          child: menu(context),
          
        ),
    );
  }
}