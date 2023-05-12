import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import '../../../blocs/blocs.dart';
import '../../../domain/entities/Note.dart';
import '../../../domain/bloc/Notes/NoteEvents.dart';
import 'package:notes_project/embedded/imageEmbedBlock.dart';
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
  late final QuillController _quillController,
      _quillControllerOld = QuillController.basic();
  final FocusNode _focusNodeTitle = FocusNode(),
      _focusNodeContent = FocusNode();
  int _quitCount = 1;

  @override
  void initState() {
    _Note = widget.note;
    _indexNote = widget.index;
    if (_Note?.title != null && _Note?.content != null) {
      _scrollController = ScrollController(initialScrollOffset: _Note!.lastScroll);
      _titleController = TextEditingController(text: _Note!.title);
      _quillController = QuillController(
          document: Document.fromJson(jsonDecode(_Note!.content)),
          selection: const TextSelection.collapsed(offset: 0));
      _quillControllerOld.clear();
      _quillControllerOld.document =
          Document.fromJson(_quillController.document.toDelta().toJson());
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
    locator.Get<NoteController>().deleteOldImages();
    _titleController.clear();
    _focusNodeContent.dispose();
    _focusNodeTitle.dispose();
    _quitCount = 1;
    _quillController.clear();
    _quillControllerOld.clear();
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
                child: QuillToolBarEditorWidget(
                    quillController: _quillController,
                    oldController: _quillControllerOld),
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
                  embedBuilders: [
                    ImageEmbedBuilder(),
                    ...FlutterQuillEmbeds.builders(),
                  ],
                  onImagePaste: _onImagePaste,
                  detectWordBoundary: true,
                  enableUnfocusOnTapOutside: true,
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
                      const EdgeInsets.only(bottom: 45, left: 15, right: 15),
                  readOnly: false,
                  scrollController: ScrollController(),
                  scrollable: false,
                  enableInteractiveSelection: true,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            homeController.compare(
                newController: _quillController,
                oldController: _quillControllerOld);
          },
          child: Icon(Icons.compare),
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
    print(_Note!.lastScroll);
    print(_scrollController.position.pixels);
    homeController.compare(
        newController: _quillController, oldController: _quillControllerOld);
  }

  Future<String> _onImagePaste(Uint8List imageBytes) async {
    // Saves the image to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final file = await File(
            '${appDocDir.path}/${basename('${DateTime.now().millisecondsSinceEpoch}.png')}')
        .writeAsBytes(imageBytes, flush: true);
    return file.path.toString();
  }
}
