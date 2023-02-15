import 'package:flutter/material.dart';
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
            icon: Icon(Icons.add),
            splashRadius: 20,
            color: Color.fromARGB(255, 255, 255, 255),
              onPressed: (){
                  Navigator.pushNamed(context, 'create_notes');
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
        body: Column(
          

        ),
                
        drawer: Container(
          width: 200,
          child: menu(context),
          
        ),
    );
  }
}