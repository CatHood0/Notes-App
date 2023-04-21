import 'package:flutter/material.dart';
import 'package:notes_project/Widgets/DialogProperties.dart';
import 'package:notes_project/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/bloc/Notes/NoteEvents.dart';
import '../../../domain/entities/Note.dart';

class DetailPage extends StatefulWidget {
  final note? Note;
  final int? index;
  final bool edit;
  const DetailPage(this.index, this.Note, {super.key, required this.edit});

  @override
  State<DetailPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<DetailPage> {
  late note? _Note;
  late TextEditingController _titleController, _contentController;
  late bool _editMode;
  late int? _indexNote = 0;
  final FocusNode _focusNodeTitle = FocusNode(),
      _focusNodeContent = FocusNode();
  int _quitCount = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_quitCount > 1 && _editMode) {
          onEdit(edit: false);
          createNote();
          return true;
        } else if (!_editMode) {
          return true;
        }
        _quitCount++;
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 58, 58, 58),
        appBar: AppBar(
          elevation: 5,
          leading: _editMode
              ? IconButton(
                  onPressed: () {
                    onEdit(edit: false);
                    unFocusedFields();
                    createNote();
                  },
                  icon: const Icon(Icons.check))
              : IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
          backgroundColor: const Color.fromARGB(255, 59, 59, 59),
          actions: [
            if (_Note != null)
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return propertiesNote(_Note!);
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
                    autofocus: _editMode,
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

  @override
  void initState() {
    _Note = widget.Note;
    _indexNote = widget.index;
    if (_Note?.title != null) {
      _titleController = TextEditingController(text: _Note!.title);
      _contentController = TextEditingController(text: _Note!.content);
    } else {
      _titleController = TextEditingController(text: "");
      _contentController = TextEditingController(text: "");
    }
    _editMode = widget.edit;
    super.initState();
  }

  @override
  void dispose() {
    _Note = null;
    _indexNote = null;
    _titleController.clear();
    _contentController.clear();
    _focusNodeContent.dispose();
    _focusNodeTitle.dispose();
    _quitCount = 0;
    super.dispose();
  }

    void onEdit({bool? edit}) {
    setState(() {
      _editMode = edit!;
    });
  }

  void unFocusedFields() {
    _focusNodeContent.unfocus();
    _focusNodeTitle.unfocus();
  }

  void createNote() {
    if (_Note != null ||
        widget.Note != null && _indexNote != null ||
        widget.index != null) {
      _Note!.title = _titleController.text;
      _Note!.content = _contentController.text;
      bloc.eventSink.add(UpdateNote(index: _indexNote!, Note: _Note!));
    } else if(_indexNote==null){
      _Note = note(
          title: _titleController.text != ""
              ? _titleController.text
              : "Untitle note",
          content: _contentController.text,
          createDate: _Note?.createDate ?? DateTime.now(),
          key: _Note?.key ?? '5',
          favorite: true,
          dateTimeModification: DateTime.now());
      bloc.eventSink.add(AddNote(Note: _Note!));
      _indexNote = bloc.getIndex(id: _Note!.key);
      _contentController.text = _Note!.content!;
    }
  }



}
