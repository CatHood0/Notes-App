import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../constant.dart';

class QuillToolBarEditorWidget extends StatelessWidget {
  const QuillToolBarEditorWidget({
    super.key,
    required QuillController quillController,
  }) : _quillController = quillController;

  final QuillController _quillController;

  @override
  Widget build(BuildContext context) {
    return QuillToolbar.basic(
      fontSizeValues: {
        'Large H': '36',
        'Medium H': '29',
        'Small H': '14',
        'Normal': '18',
      },
      fontFamilyValues: fontFamilyOptions,
      toolbarIconSize: 24,
      iconTheme: QuillIconTheme(
        borderRadius: 30,
      ),
      showCodeBlock: false,
      showHeaderStyle: false,
      showJustifyAlignment: false,
      showStrikeThrough: false,
      showDirection: false,
      showSmallButton: false,
      showInlineCode: false,
      showQuote: false,
      showListCheck: false,
      showUndo: false,
      showIndent: false,
      showSubscript: false,
      showSuperscript: false,
      showRedo: false,
      toolbarSectionSpacing: 10,
      controller: _quillController,
      multiRowsDisplay: false,
      embedButtons: FlutterQuillEmbeds.buttons(
        onImagePickCallback: _onImagePickCallback,
        showCameraButton: false,
      ),
      showAlignmentButtons: true,
    );
  }

  Future<String> _onImagePickCallback(File file) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }
}
