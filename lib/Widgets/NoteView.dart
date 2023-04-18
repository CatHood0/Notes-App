import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../bloc/Notes/NoteBloc.dart';
import '../data/provider/noteNProvider.dart';
import '../domain/entities/Note.dart';
import '../UI/notes/ReadNote.dart';

class noteCard extends ConsumerStatefulWidget {
  final note Note;
  final int index;
  final NoteBloc bloc;
  noteCard(this.Note, this.index, {super.key, required this.bloc});

  @override
  ConsumerState<noteCard> createState() => _noteCardState();
}

class _noteCardState extends ConsumerState<noteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: GestureDetector(
        onTap: () async {
          final Note = new note(
              title: widget.Note.Title,
              content: widget.Note.Content,
              createDate: widget.Note.Date,
              key: widget.Note.Key,
              favorite: widget.Note.Favorite,
              dateTimeModification:
                  widget.Note.DateModification);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => readPage(widget.index, Note, bloc: widget.bloc)));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 10,
            color: Color.fromARGB(255, 105, 105, 105),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        final favorite =
                            !widget.Note.Favorite;
                        ref.read(noteNotifierProvider.notifier).setFavorite(
                            widget.index,
                            note(
                                title: widget.Note.Title,
                                content: widget.Note.Content,
                                createDate: widget.Note.Date,
                                key: widget.Note.Key,
                                favorite: favorite,
                                dateTimeModification: DateTime.now()));
                      },
                      icon: widget.Note.Favorite
                          ? Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 240, 153, 255),
                            )
                          : Icon(
                              Icons.star_outline,
                              color: Color.fromARGB(255, 240, 153, 255),
                            ),
                      splashRadius: 20,
                      tooltip: "Tap your favorite note",
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
                    child: widget.Note.Title.trim() != ""
                        ? Center(
                            child: Text(
                              widget.Note.Title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 3,
                              softWrap: true,
                            ),
                          )
                        : Text(
                            widget.Note.Content + '...',
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
