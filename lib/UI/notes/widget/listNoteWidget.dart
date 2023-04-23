import 'package:flutter/material.dart';
import '../../../Widgets/NoteView.dart';
import '../../../domain/bloc/Notes/NoteBloc.dart';
import '../../../domain/bloc/Notes/NoteStates.dart';

class ListNotesBlocWidget extends StatelessWidget {
  const ListNotesBlocWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: StreamBuilder<NoteState>(
        stream: bloc.stateStream,
        builder: (context, snapshot) {
          if (snapshot.data is LoadedNotes) {
            final data = (snapshot.data as LoadedNotes).notes;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: data.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return NoteCard(data[index], index);
              },
            );
          } else if (snapshot.data is LoadingNotes) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data is NoteNotFound) {
            final error = (snapshot.data as NoteNotFound).onError;
            return Center(
              child: Text(
                error,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            );
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
