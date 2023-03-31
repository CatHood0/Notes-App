// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:notes_project/data/local/NotesRepository.dart';
import '../domain/entities/Note.dart';
import '../UI/notes/ReadNote.dart';

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
        onTap: () async {
          final Note = new note(
              title: widget._listNote[widget.index].Title,
              content: widget._listNote[widget.index].Content,
              createDate: widget._listNote[widget.index].Date,
              key: widget._listNote[widget.index].Key,
              favorite: widget._listNote[widget.index].Favorite,
              dateTimeModification: widget._listNote[widget.index].DateModification);
          await Navigator.push(context, MaterialPageRoute(builder: (context) => readPage(widget.index, Note)));
          setState(() {});
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
                          });
                        },
                        icon: widget._listNote[widget.index].Favorite
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
                            "Tap your favorite note",
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
                      child: widget._listNote[widget.index].Title.trim()!="" ?
                      Center(
                        child: Text(
                          widget._listNote[widget.index].Title,
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
                        widget._listNote[widget.index].Content+'...',
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
