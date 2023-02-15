import 'package:flutter/material.dart';

class customCard extends StatelessWidget {
  
  String title;
  String content;
  DateTime createTime;
  
  customCard(this.title, 
  this.content, 
  this.createTime, 
  {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(

        ),
    );
  }
}