import 'package:flutter/material.dart';

class createNote extends StatelessWidget {
  const createNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 92, 92, 92),
        elevation: 0,
        title: Text("New note", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
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
        body: Column(
          children: [
              Row(),  
              Container(),
              Container(),



          ],
        ),
    );
  }
}