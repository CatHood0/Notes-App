import 'package:flutter/material.dart';
import 'package:notes_project/main.dart';
import '../domain/entities/Note.dart';
import '../UI/notes/screens/DetailPage.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  final int index;
  final bool isHomePage;
  const NoteCard(this.note, this.index, {super.key, this.isHomePage = false});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard>
    with TickerProviderStateMixin {
  final bloc = blocInject.getBloc<NoteBloc>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width * 0.50,
      child: GestureDetector(
        onLongPress: () {
          bloc.eventSink.add(DeleteNote(index: widget.index));
        },
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(
                        widget.index,
                        widget.note,
                        edit: false,
                      )));
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          color: const Color.fromARGB(145, 87, 87, 87),
          child: Stack(
            children: [
              NoteTitleWidget(
                  widget: widget.note, isHomePage: widget.isHomePage),
              DateAndStartNoteWidget(
                noteCard: widget,
                bloc: bloc,
                isHomePage: widget.isHomePage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateAndStartNoteWidget extends StatelessWidget {
  const DateAndStartNoteWidget({
    super.key,
    required this.bloc,
    required this.noteCard,
    required this.isHomePage,
  });

  final NoteCard noteCard;
  final NoteBloc bloc;
  final bool isHomePage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: !isHomePage ? 10 : 10,
      right: !isHomePage ? -5 : -5,
      top: !isHomePage ? 200 : 120,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(timeago.format(noteCard.note.dateTimeModification)),
            IconButton(
              onPressed: () {
                final favorite = !noteCard.note.favorite;
                bloc.eventSink.add(
                    FavoriteNote(index: noteCard.index, isFavorite: favorite));
              },
              icon: noteCard.note.favorite
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
      ),
    );
  }
}

class NoteTitleWidget extends StatelessWidget {
  const NoteTitleWidget({
    super.key,
    required this.widget,
    required this.isHomePage,
  });

  final Note widget;
  final bool isHomePage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: widget.title.length < 15 ? 75 : 0,
      bottom: calculateSizeTitleNoteCard(title: widget.title, isHomePage: isHomePage),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: !isHomePage ? 18 : 16),
              maxLines: !isHomePage ? 3 : 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          )),
    );
  }

  double calculateSizeTitleNoteCard({required String title, required bool isHomePage}) {
    //For notePage
    if (title.trim().length < 10 && title.trim().length > 1 && !isHomePage) {
      return 190;
    } else if (title.trim().length < 15 && !isHomePage) {
      return 190;
    } else if (title.trim().length > 16 &&
        title.trim().length < 25 &&
        !isHomePage) {
      return 170;
    } else if (title.trim().length > 25 &&
        title.trim().length < 30 &&
        !isHomePage) {
      return 170;
    } else if (title.trim().length > 31 &&
        title.trim().length < 40 &&
        !isHomePage) {
      return 140;
    }

    //For HomePage
    if (title.trim().length < 10 && title.trim().length > 1 && isHomePage) {
      return 130;
    } else if (title.trim().length < 15 && isHomePage) {
      return 110;
    } else if (title.trim().length > 16 &&
        title.trim().length < 25 &&
        isHomePage) {
      return 130;
    } else if (title.trim().length > 25 &&
        title.trim().length < 30 &&
        isHomePage) {
      return 110;
    } else if (title.trim().length > 31 && isHomePage) {
      return 110;
    }
    return 160;
  }
}
