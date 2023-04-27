import 'package:flutter/material.dart';
import 'package:notes_project/main.dart';
import '../../../Widgets/note_card.dart';
import '../../../blocs(Exports)/blocs.dart';
import '../../../domain/bloc/Notes/NoteStates.dart';
import '../../notes/widget/listNoteWidget.dart';

class NoteListWidget extends StatelessWidget {
   NoteListWidget({
    super.key,
  });

  final NoteBloc noteBloc = blocInject.getBloc<NoteBloc>();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: StreamBuilder<NoteState>(
            stream: noteBloc.stateStream,
            builder: (context, snapshot) {
              if (snapshot.data is LoadedNotes) {
                final data = (snapshot.data as LoadedNotes).notes;
                return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: ScrollController(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: NoteCard(
                          data[index],
                          index,
                          isHomePage: true,
                        ),
                      );
                    });
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
                textAlign: TextAlign.justify,
              ));
            }),
      ),
    );
  }
}