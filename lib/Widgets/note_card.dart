import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:notes_project/UI/home/controller/HomeController.dart';
import 'package:notes_project/data/local%20/sqflite/note_local_repo.dart';
import 'package:notes_project/main.dart';
import '../domain/entities/Note.dart';
import '../UI/notes/screens/DetailPage.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  final int index;
  final bool showStart;
  final bool isHomePage;
  const NoteCard(this.note, this.index,
      {super.key, this.isHomePage = false, this.showStart = false});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> with TickerProviderStateMixin {
  late Timer? timer;

  @override
  void initState() {
      timer = Timer.periodic(Duration(minutes: 1), (timer) {
          TimerFallBack();
      });
    super.initState();
  }

  @override
  void dispose() {
    if (timer!.isActive) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width * 0.50,
      child: GestureDetector(
        onLongPress: () {
          locator.Get<NoteBloc>()
              .eventSink
              .add(DeleteNote(index: widget.index));
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
              DateAndStarNoteWidget(
                showStar: widget.showStart,
                noteCard: widget,
                isHomePage: widget.isHomePage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void TimerFallBack() {
    setState(() {});
  }
}

class DateAndStarNoteWidget extends StatefulWidget {
  const DateAndStarNoteWidget({
    super.key,
    required this.showStar,
    required this.noteCard,
    required this.isHomePage,
  });

  final bool showStar;
  final NoteCard noteCard;
  final bool isHomePage;

  @override
  State<DateAndStarNoteWidget> createState() => _DateAndStarNoteWidgetState();
}

class _DateAndStarNoteWidgetState extends State<DateAndStarNoteWidget> {
  @override
  Widget build(BuildContext context) {
    final HomeController _homeController =
        HomeController(db: NoteLocalRepository());
    return Positioned(
      left: !widget.isHomePage ? 10 : 10,
      right: !widget.isHomePage ? -5 : -5,
      top: !widget.isHomePage ? 200 : 120,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(timeago.format(widget.noteCard.note.dateTimeModification)),
            if (widget.showStar)
              IconButton(
                onPressed: () {
                  final favorite =
                      !widget.noteCard.note.favorite ? true : false;
                  Note note = widget.noteCard.note.copyWith(favorite: favorite);
                  _homeController.updateLocalNote(note: note);
                  locator.Get<NoteBloc>().eventSink.add(FavoriteNote(
                      index: widget.noteCard.index, isFavorite: note.favorite));
                },
                icon: widget.noteCard.note.favorite
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
      bottom: calculateSizeTitleNoteCard(
          title: widget.title, isHomePage: isHomePage),
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

  double calculateSizeTitleNoteCard(
      {required String title, required bool isHomePage}) {
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
      return 115;
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
