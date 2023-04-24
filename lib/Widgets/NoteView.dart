import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/main.dart';
import '../domain/entities/Note.dart';
import '../UI/notes/screens/DetailPage.dart';

class NoteCard extends ConsumerStatefulWidget {
  final note Note;
  final int index;
  const NoteCard(this.Note, this.index, {super.key});

  @override
  ConsumerState<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends ConsumerState<NoteCard>
    with TickerProviderStateMixin {
  final NoteBloc bloc = blocInject.getBloc<NoteBloc>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                        widget.Note,
                        edit: false,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            color: Color.fromARGB(145, 87, 87, 87),
            child: Stack(
              children: [
                NoteTitleWidget(widget: widget),
                DateAndStartNoteWidget(noteCard: widget,bloc: bloc),
              ],
            ),
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
  });

  final NoteCard noteCard;
  final NoteBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      right: -5,
      top: 200,
      bottom: 0,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                  noteCard.Note.dateTimeModification.hour.toString()),
            ),
            IconButton(
              onPressed: () {
                final favorite = !noteCard.Note.favorite;
                bloc.eventSink.add(FavoriteNote(
                    index: noteCard.index, isFavorite: favorite));
              },
              icon: noteCard.Note.favorite
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
  });

  final NoteCard widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: calculateSizeTitle(title: widget.Note.title),
      child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 10),
          child: Center(
            child: Text(
              widget.Note.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              maxLines: 3,
              textAlign: TextAlign.start,
            ),
          )),
    );
  }

  double calculateSizeTitle({required String title}){
    if(title.length<15){
      return 190;
    }
    else if(title.length>16 && title.length<25){
      return 190;
    }
    else if(title.length>25){
      return 140;
    }
    return 160;
  }


}
