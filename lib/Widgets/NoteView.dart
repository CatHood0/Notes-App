// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:notes_project/controller/NoteController.dart';
import '../model/Note.dart';
import '../view/ReadNote.dart';

class noteCard extends StatefulWidget {
  List<note> _listNote;
  int index;
  noteCard(this._listNote, this.index, {super.key});

  @override
  State<noteCard> createState() => _noteCardState();
}

class _noteCardState extends State<noteCard> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: GestureDetector(
        onTap: () {
          final Note = new note(
              widget._listNote[widget.index].getTitle(),
              widget._listNote[widget.index].getContent(),
              widget._listNote[widget.index].getDate(),
              widget._listNote[widget.index].getId(),
              widget._listNote[widget.index].getFavorite(),
              widget._listNote[widget.index].getDateModification());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => readPage(widget.index, Note)));
          print(widget.index);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 10,
            color: Color.fromARGB(255, 105, 105, 105),
            child: Column(
              children: [
                   Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget._listNote[widget.index].getFavorite()
                                ? noteController.setFavorite(widget.index, false)
                                : noteController.setFavorite(widget.index, true);
                          });
                        },
                        icon: widget._listNote[widget.index].getFavorite()
                            ? Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 240, 153, 255),
                              )
                            : Icon(
                                Icons.star_outline,
                                color: Color.fromARGB(255, 240, 153, 255),
                              ),
                        splashRadius: 20,
                        tooltip:
                            "Select star for convert this note in your favorite",
                      ),
                    ],
                  ),       
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    top: 15,
                    right: 14,
                  ),
                  child: Container(
                      child: widget._listNote[widget.index].getTitle().trim()!="" ?
                      Center(
                        child: Text(
                          widget._listNote[widget.index].getTitle(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          maxLines: 3,
                          softWrap: true,
                        ),
                      )
                      :
                      Text(
                        widget._listNote[widget.index].getContent(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        maxLines: 3,
                        softWrap: true,
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

}
