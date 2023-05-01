import 'package:flutter/material.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import '../../../domain/enums/enums.dart';
import '../../../main.dart';

enum listOptions { orderByTitle, orderByCreationDate, orderByModificationDate }

class PopupMenu extends StatefulWidget {
  const PopupMenu({super.key});

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  listOptions? selectedItem = listOptions.orderByTitle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<listOptions>(
      tooltip: "Show options",
      initialValue: selectedItem,
      color: const Color.fromARGB(255, 70, 70, 70),
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (listOptions item) {
        setState(() {
          selectedItem = item;
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 15,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<listOptions>>[
        PopupMenuItem<listOptions>(
          onTap: () {
            locator.Get<NoteBloc>()
                .eventSink
                .add(SortNotesEvents(sort: TypeSort.title));
          },
          value: listOptions.orderByTitle,
          child: const Text(
            'Order by title',
            style: TextStyle(color: Colors.white),
          ),
        ),
        PopupMenuItem<listOptions>(
          onTap: () {
            setState(
              () {
                locator.Get<NoteBloc>()
                    .eventSink
                    .add(SortNotesEvents(sort: TypeSort.creation));
              },
            );
          },
          value: listOptions.orderByCreationDate,
          child: const Text(
            'Order by date',
            style: TextStyle(color: Colors.white),
          ),
        ),
        PopupMenuItem<listOptions>(
          onTap: () {
            setState(
              () {
                locator.Get<NoteBloc>()
                    .eventSink
                    .add(SortNotesEvents(sort: TypeSort.modification));
              },
            );
          },
          value: listOptions.orderByModificationDate,
          child: const Text(
            'Order by modification date',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
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
