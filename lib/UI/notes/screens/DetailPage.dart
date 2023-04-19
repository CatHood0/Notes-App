import 'package:flutter/material.dart';
import 'package:notes_project/Widgets/DialogProperties.dart';
import 'package:notes_project/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/bloc/Notes/NoteEvents.dart';
import '../../../domain/entities/Note.dart';

class DetailPage extends StatefulWidget {
  final note? Note;
  final int? index;
  final bool edit;
  const DetailPage(this.index, this.Note,
      {super.key, required this.edit});

  @override
  State<DetailPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<DetailPage> {
  late note? Note;
  late TextEditingController _titleController, _contentController;
  late bool editMode;
  final FocusNode _focusNodeTitle = FocusNode(),
      _focusNodeContent = FocusNode();
  int quitCount = 0;

  void onEdit({bool? edit}) {
    setState(() {
      editMode = edit!;
    });
  }

  void unFocusedFields() {
    _focusNodeContent.unfocus();
    _focusNodeTitle.unfocus();
  }

  void createNote() {
    if (widget.index != null && widget.Note != null) {
      Note!.title = _titleController.text;
      Note!.content = _contentController.text;
      bloc.eventSink.add(UpdateNote(index: widget.index!, Note: Note!));
    } else {
      Note = note(
          title: _titleController.text != ""
              ? _titleController.text
              : "Untitle note",
          content: _contentController.text,
          createDate: Note?.createDate ?? DateTime.now(),
          key: Note?.Key ?? '1',
          favorite: true,
          dateTimeModification: DateTime.now());
      bloc.eventSink.add(AddNote(Note: Note!));
      _titleController.text = Note!.Title;
      _contentController.text = Note!.Content;
    }
  }

  @override
  void initState() {
    Note = widget.Note;
    if (Note?.title != null) {
      _titleController = TextEditingController(text: Note!.title);
      _contentController = TextEditingController(text: Note!.content);
    } else {
      _titleController = TextEditingController(text: "");
      _contentController = TextEditingController(text: "");
    }
    editMode = widget.edit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (quitCount > 0 && editMode) {
          onEdit(edit: false);
          createNote();
          return true;
        } else if (!editMode) {
          return true;
        }
        quitCount++;
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 58, 58, 58),
        appBar: AppBar(
          elevation: 5,
          leading: editMode
              ? IconButton(
                  onPressed: () {
                    onEdit(edit: false);
                    unFocusedFields();
                    createNote();
                    if(widget.index==null) Navigator.pop(context);
                  },
                  icon: const Icon(Icons.check))
              : IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
          backgroundColor: const Color.fromARGB(255, 59, 59, 59),
          actions: [
            if (Note != null)
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return propertiesNote(Note!);
                    },
                  );
                },
                icon: const Icon(Icons.insert_drive_file),
              ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    focusNode: _focusNodeTitle,
                    controller: _titleController,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      onEdit(edit: true);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    focusNode: _focusNodeContent,
                    autocorrect: true,
                    autofocus: editMode,
                    controller: _contentController,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                    decoration: const InputDecoration.collapsed(
                      hintText: "Write something",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      onEdit(edit: true);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
