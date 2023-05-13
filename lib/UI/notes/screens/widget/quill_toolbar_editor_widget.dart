import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../../../../constant.dart';


class QuillToolBarEditorWidget extends StatelessWidget {
  const QuillToolBarEditorWidget({
    super.key,
    required this.quillController,
  });
  final QuillController quillController;

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
      showSubscript: false,
      showSuperscript: false,
      showDirection: false,
      showSmallButton: false,
      showInlineCode: false,
      showQuote: false,
      showListCheck: false,
      showUndo: false,
      showIndent: false,
      showRedo: false,
      toolbarSectionSpacing: 10,
      controller: quillController,
      multiRowsDisplay: false,
      showAlignmentButtons: true,
    );
  }

}
