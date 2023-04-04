import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/Note.dart';

class notesNotifier extends StateNotifier<List<note>> {
  notesNotifier()
      : super([
          note(
              title: "Hola",
              content: "Contenido",
              createDate: DateTime.now(),
              key: 0,
              favorite: true,
              dateTimeModification:
                  DateTime.now()), //this can nullable if is: [];
        ]);

  void addNote(note Note) {
    state = [
      ...state,
      Note
    ];
  }

  void setFavorite(int index, note Note){
    final List<note> list = state;
    list[index] = Note;
    state = [...list]; 
  }


}
