import 'package:flutter/material.dart';
import 'package:notes_project/controller/NoteController.dart';
import 'package:notes_project/view/Pages.dart';

enum listOptions { listAllNotes, listFavoriteNotes, backup, restore }

class popupMenu extends StatefulWidget {
  popupMenu({super.key});

  @override
  State<popupMenu> createState() => _popupMenuState();
}

class _popupMenuState extends State<popupMenu> {
  listOptions? selectedItem = listOptions.listAllNotes;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<listOptions>(
      tooltip: "Show options",
      initialValue: selectedItem,
      color: Color.fromARGB(255, 70, 70, 70),
      icon: Icon(
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
          value: listOptions.listAllNotes,
          child: Text(
            'Show all notes',
            style: TextStyle(color: Colors.white),
          ),
        ),
        PopupMenuItem<listOptions>(
          onTap: () {
            setState(() {
                
              },
            );
          },
          value: listOptions.listFavoriteNotes,
          child: Text(
            'Show only favorites',
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
