import 'package:flutter/material.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/main.dart';
import '../../../Widgets/note_card.dart';
import '../../../domain/bloc/Notes/NoteEvents.dart';
import '../../../domain/bloc/Notes/NoteStates.dart';

class ListNotesBlocWidget extends StatefulWidget {
  const ListNotesBlocWidget({
    super.key,
  });

  @override
  State<ListNotesBlocWidget> createState() => _ListNotesBlocWidgetState();
}

class _ListNotesBlocWidgetState extends State<ListNotesBlocWidget> {
  final NoteBloc bloc = locator.Get<NoteBloc>();
  @override
  void initState() {
    // noteBloc.eventSink.add(SortNotesEvents(sort: CurrentTypeSortSelectedFromPreferences));
    bloc.eventSink.add(RestoreNoteFiles());
    super.initState();
  }

  @override
  void dispose() {
    // noteBloc.eventSink.add(SortNotesEvents(sort: TypeSort.recent));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: StreamBuilder<NoteState>(
        stream: bloc.stateStream,
        builder: (context, snapshot) {
          if (snapshot.data is LoadedNotes) {
            final data = (snapshot.data as LoadedNotes).notes;
            final show = (snapshot.data as LoadedNotes).showStar;
            return GridNotesWidget(
              data: data,
              showStar: show,
            );
          } else if (snapshot.data is LoadingNotes) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data is NoteNotFound) {
            final error = (snapshot.data as NoteNotFound).onError;
            return ErrorMessageWidget(error: error);
          }
          return const Center(
              child: Text(
            '¡Ops!, may that the service is not working',
            style: TextStyle(color: Colors.white),
          ));
        },
      ),
    );
  }
}

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class GridNotesWidget extends StatelessWidget {
  const GridNotesWidget({
    super.key,
    required this.data,
    required this.showStar,
  });

  final bool showStar;
  final List<Note> data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: NoteCard(data[index], index, showStart: showStar),
        );
      },
    );
  }
}
