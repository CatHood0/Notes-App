import 'package:flutter/material.dart';
import 'package:notes_project/controller/CreateNoteController.dart';

// ignore: must_be_immutable
class customCard extends StatefulWidget {
  
  int id;
  String title;
  String content;
  DateTime createTime;
  
  customCard(this.id, this.title,
  this.content, 
  this.createTime, 
  {super.key}
  );

  String getTitle(){
    return title;
  }

  int getIdCard(){
    return id;
  }

  void setTitle(String title){
    title = title;
  }

  void setContentCard(String content){
    content = content;
  }

  @override
  State<customCard> createState() => _customCardState(this);
}

class _customCardState extends State<customCard> {
  
  customCard card;
  _customCardState(this.card);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        child: Card(
           
            child: Stack(
                children: [
                    Container(
                        
                       
                    ),
      
                ],
            ),
        ),
      ),
    );
  }
}