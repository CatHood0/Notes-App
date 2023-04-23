import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_project/Widgets/DialogProperties.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
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
  late TextEditingController _titleController;
  late bool _editMode;
  late int? _indexNote = 0;
  late final QuillController _quillController;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNodeTitle = FocusNode(),
      _focusNodeContent = FocusNode();
  int _quitCount = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_quitCount > 0 && _editMode) {
          onEdit(edit: false);
          createNote();
          return false;
        } else if (!_editMode) {
          return true;
        }
        _quitCount++;
        return false;
      },
      child: Scaffold(
        bottomSheet: Container(
          child: QuillToolbar.basic(controller: _quillController,
            multiRowsDisplay: false,
          ),
        ),
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
                      return PropertiesNote(currentNote: _Note!);
                    },
                  );
                },
                icon: const Icon(Icons.insert_drive_file),
              ),
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
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
                        fontSize: 22, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: "Title",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
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
                child: QuillEditor(
                  detectWordBoundary: true,
                  scrollPhysics: const AlwaysScrollableScrollPhysics(),
                  placeholder: "Write your throughs",
                  controller: _quillController,
                  autoFocus: false,
                  onTapUp: (details, p1) {
                    if (!_editMode) {
                      onEdit(edit: true);
                    }
                    _focusNodeTitle.unfocus();
                    return false;
                  },
                  onLaunchUrl: (String url) {},
                  expands: false,
                  customStyles:
                      DefaultStyles(link: const TextStyle(color: Colors.white)),
                  onImagePaste: (imageBytes) async {
                    return;
                  },
                  focusNode: _focusNodeContent,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  readOnly: false,
                  scrollController: _scrollController,
                  scrollable: false,
                  enableSelectionToolbar: true,
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
      _quillController = QuillController(
          document: Document.fromJson(jsonDecode(_Note!.content)),
          selection: const TextSelection.collapsed(offset: 0));
    } else {
      _titleController = TextEditingController(text: "");
      _quillController = QuillController.basic();
    }
    _editMode = widget.edit;
    super.initState();
  }

  @override
  void dispose() {
    _Note = null;
    _indexNote = null;
    _titleController.clear();
    _focusNodeContent.dispose();
    _focusNodeTitle.dispose();
    _quitCount = 0;
    _quillController.clear();
    _scrollController.dispose();
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
      _Note!.title =
          _titleController.text == "" ? "Untitle note" : _titleController.text;
      _Note!.content = jsonEncode(_quillController.document.toDelta().toJson());
      _Note!.dateTimeModification = DateTime.now();
      bloc.eventSink.add(UpdateNote(index: _indexNote!, notes: _Note!));
    } else if (_indexNote == null) {
      _Note = note(
          title: _titleController.text != ""
              ? _titleController.text
              : "Untitle note",
          content: jsonEncode(_quillController.document.toDelta().toJson()),
          createDate: _Note?.createDate ?? DateTime.now(),
          key: _Note?.key ?? '5',
          favorite: true,
          dateTimeModification: DateTime.now());
      bloc.eventSink.add(AddNote(Note: _Note!));
      _indexNote = bloc.getIndex(id: _Note!.key);
    }
  }
}
