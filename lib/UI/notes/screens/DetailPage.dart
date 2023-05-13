import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:convert';
import 'dart:ui';
import '../../../blocs/blocs.dart';
import '../../../domain/entities/Note.dart';
import '../../../domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/UI/notes/screens/widget/quill_toolbar_only.dart';
import 'package:notes_project/UI/notes/screens/widget/quill_toolbar_editor_widget.dart';
import 'package:notes_project/UI/notes/controller/NoteController.dart';
import 'package:notes_project/UI/notes/widget/DialogProperties.dart';
import 'package:notes_project/UI/notes/widget/dateTimeTextDetail.dart';
import 'package:notes_project/constant.dart';
import 'package:notes_project/main.dart';

class DetailPage extends StatefulWidget {
  final Note? note;
  final int? index;
  final bool edit;
  const DetailPage(this.index, this.note, {super.key, required this.edit});

  @override
  State<DetailPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<DetailPage> {
  final homeController = locator.Get<NoteController>();
  late Note? _Note;
  late TextEditingController _titleController;
  late final ScrollController _scrollController;
  late bool _editMode;
  late int? _indexNote = 0;
  late final QuillController _quillController;
  final FocusNode _focusNodeTitle = FocusNode(),
      _focusNodeContent = FocusNode();
  int _quitCount = 1;

  @override
  void initState() {
    _Note = widget.note;
    _indexNote = widget.index;
    if (_Note?.title != null && _Note?.content != null && _Note!.content.isNotEmpty) {
      _scrollController =
          ScrollController(initialScrollOffset: _Note!.lastScroll);
      _titleController = TextEditingController(text: _Note!.title);
      _quillController = QuillController(
          document: Document.fromJson(jsonDecode(_Note!.content)),
          selection: const TextSelection.collapsed(offset: 0));
    } else {
      _scrollController = ScrollController();
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
    _quitCount = 1;
    _quillController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_quitCount > 1 && _editMode) {
          onEdit(edit: false);
          createNote();
          return false;
        } else if (!_editMode) {
          _quitCount = 1;
          return true;
        }
        _quitCount++;
        return false;
      },
      child: Scaffold(
        bottomSheet: _editMode && !_focusNodeTitle.hasFocus
            ? Container(
                child:
                    QuillToolBarEditorWidget(quillController: _quillController),
              )
            : Container(
                height: 0,
              ),
        appBar: AppBar(
          elevation: 5,
          leading: _editMode
              ? IconButton(
                  onPressed: () {
                    onEdit(edit: false);
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
            if (_editMode && !_focusNodeTitle.hasFocus)
              QuillToolBarWidgetOnlyUndoRedo(quillController: _quillController),
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
                  placeholder: "Write something",
                  controller: _quillController,
                  autoFocus: false,
                  detectWordBoundary: true,
                  minHeight: MediaQuery.of(context).size.height * 1,
                  textCapitalization: TextCapitalization.sentences,
                  onSingleLongTapStart: (details, p1) {
                    return focusEditor();
                  },
                  onTapUp: (details, p1) {
                    return focusEditor();
                  },
                  customStyles: DefaultStyles(
                      // Define your own styles here
                      sizeSmall: TextStyle(fontFamily: 'Arial', fontSize: 16),
                      link: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1.5,
                          decorationColor: Colors.blue.shade300,
                          color: Colors.blue.shade300,
                          inherit: true,
                          fontFeatures: <FontFeature>[
                            FontFeature.enable('smcp'),
                          ])),
                  onLaunchUrl: (String url) {
                    launchUrlString(url);
                  },
                  expands: false,
                  focusNode: _focusNodeContent,
                  padding:
                      const EdgeInsets.only(bottom: 60, left: 15, right: 15),
                  readOnly: false,
                  scrollController: ScrollController(),
                  scrollable: false,
                  enableInteractiveSelection: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onEdit({bool? edit}) {
    setState(() {
      _editMode = edit!;
    });
  }

  void unFocusNode(FocusNode node) {
    setState(() {
      node.unfocus();
    });
  }

  bool focusEditor() {
    if (!_editMode) {
      onEdit(edit: true);
    }
    unFocusNode(_focusNodeTitle);
    return false;
  }

  void createNote() async {
    _focusNodeContent.unfocus();
    _focusNodeTitle.unfocus();
    if (_Note != null ||
        widget.note != null && _indexNote != null ||
        widget.index != null) {
      _Note = _Note!.copyWith(
        title: _titleController.text == ""
            ? "Untitle note"
            : _titleController.text,
        content: jsonEncode(_quillController.document.toDelta().toJson()),
        readable: _quillController.document.toPlainText(),
        last: _scrollController.position.pixels,
        dateTimeModification: DateTime.now(),
      );
      homeController.updateLocalNote(note: _Note!);
      locator.Get<NoteBloc>()
          .eventSink
          .add(UpdateNote(index: _indexNote!, notes: _Note!));
    } else if (_indexNote == null) {
      Note note = Note(
          title: _titleController.text != ""
              ? _titleController.text
              : "Untitle note",
          content: jsonEncode(_quillController.document.toDelta().toJson()),
          readable: _quillController.document.toPlainText(),
          createDate: _Note?.createDate ?? DateTime.now(),
          favorite: false,
          password: null,
          lastScroll: _scrollController.position.pixels,
          dateTimeModification: DateTime.now());

      int id = await homeController.insertLocalNote(note: note);
      _Note = note.copyWith(key: id);
      locator.Get<NoteBloc>().eventSink.add(AddNote(note: _Note!));
      _indexNote = locator.Get<NoteBloc>().getIndex();
    }
  }
}
