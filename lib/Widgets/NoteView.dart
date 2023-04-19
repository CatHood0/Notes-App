import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../data/provider/noteNProvider.dart';
import '../domain/entities/Note.dart';
import '../UI/notes/screens/DetailPage.dart';

class NoteCard extends ConsumerStatefulWidget {
  final note Note;
  final int index;
  const NoteCard(this.Note, this.index, {super.key});

  @override
  ConsumerState<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends ConsumerState<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: GestureDetector(
        onTap: () async {
          final Note = note(
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
                  builder: (context) => DetailPage(widget.index, Note, edit: false,)));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 10,
            color: const Color.fromARGB(255, 105, 105, 105),
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
                          ? const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 240, 153, 255),
                            )
                          : const Icon(
                              Icons.star_outline,
                              color: Color.fromARGB(255, 240, 153, 255),
                            ),
                      splashRadius: 20,
                      tooltip: "Tap your favorite note",
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 15,
                    right: 14,
                  ),
                  child: Container(
                    child: widget.Note.Title.trim() != ""
                        ? Center(
                            child: Text(
                              widget.Note.Title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              maxLines: 3,
                              softWrap: true,
                            ),
                          )
                        : Text(
                            '${widget.Note.Content}...',
                            style: const TextStyle(
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
