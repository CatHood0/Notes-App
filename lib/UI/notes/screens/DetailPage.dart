import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:notes_project/UI/notes/widget/DialogProperties.dart';
import 'package:notes_project/UI/notes/widget/dateTimeTextDetail.dart';
import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/bloc/Notes/NoteBloc.dart';
import 'package:notes_project/domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/main.dart';
import '../../../domain/entities/Note.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final Note? note;
  final int? index;
  final bool edit;
  const DetailPage(this.index, this.note, {super.key, required this.edit});

  @override
  State<DetailPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<DetailPage> {
  final NoteBloc bloc = blocInject.getBloc<NoteBloc>();
  late Note? _Note;
  late TextEditingController _titleController;
  late bool _editMode;
  late int? _indexNote = 0;
  late final QuillController _quillController;
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
          child: QuillToolbar.basic(
            toolbarSectionSpacing: 10,
            controller: _quillController,
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
                  icon: const Icon(Icons.check),
                  style: ButtonStyle(
                      iconColor: MaterialStatePropertyAll(buttonGeneralColor)))
              : IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
          actions: <Widget>[
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
            IconButton(
              icon: Icon(Icons.tag_outlined),
              onPressed: () {
                //Logic for add tags
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                height: MediaQuery.of(context).size.height * 0.045,
                child: dateTimeText(
                  time: DateFormat.yMMMEd()
                      .format(_Note?.createDate ?? DateTime.now())
                      .toString(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    focusNode: _focusNodeTitle,
                    controller: _titleController,
                    style: const TextStyle(
                        fontSize: 27, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration.collapsed(
                      hintText: "Title",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
                    ),
                    keyboardType: TextInputType.text,
                    minLines: 1,
                    maxLines: null,
                    onTap: () {
                      onEdit(edit: true);
                    },
                  ),
                ),
              ),
              Container(
                child: QuillEditor(
                  detectWordBoundary: true,
                  placeholder: "Write something",
                  controller: _quillController,
                  autoFocus: false,
                  textCapitalization: TextCapitalization.sentences,
                  onTapUp: (details, p1) {
                    if (!_editMode) {
                      onEdit(edit: true);
                    }
                    _focusNodeTitle.unfocus();
                    return false;
                  },
                  onLaunchUrl: (String url) {
                    launchUrlString(url);
                  },
                  expands: false,
                  customStyles:
                      DefaultStyles(link: const TextStyle(color: Colors.white)),
                  focusNode: _focusNodeContent,
                  padding:
                      const EdgeInsets.only(bottom: 60, left: 15, right: 15),
                  readOnly: false,
                  scrollController: ScrollController(),
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
    _Note = widget.note;
    _indexNote = widget.index;
    if (_Note?.title != null && _Note?.content != null) {
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
        widget.note != null && _indexNote != null ||
        widget.index != null) {
      _Note = _Note!.copyWith(
        title: _titleController.text == ""
            ? "Untitle note"
            : _titleController.text,
        content: jsonEncode(_quillController.document.toDelta().toJson()),
        update: _Note!.updates + 1,
        dateTimeModification: DateTime.now(),
      );
      bloc.eventSink.add(UpdateNote(index: _indexNote!, notes: _Note!));
    } else if (_indexNote == null) {
      _Note = Note(
          title: _titleController.text != ""
              ? _titleController.text
              : "Untitle note",
          content: jsonEncode(_quillController.document.toDelta().toJson()),
          createDate: _Note?.createDate ?? DateTime.now(),
          key: _Note?.key ?? '5',
          favorite: true,
          tag: ['anything'],
          updates: 0,
          dateTimeModification: DateTime.now());
      bloc.eventSink.add(AddNote(note: _Note!));
      _indexNote = bloc.getIndex();
    }
  }
}
