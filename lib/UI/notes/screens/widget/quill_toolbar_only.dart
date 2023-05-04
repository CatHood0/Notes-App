import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class QuillToolBarWidgetOnlyUndoRedo extends StatelessWidget {
  const QuillToolBarWidgetOnlyUndoRedo({
    super.key,
    required QuillController quillController,
  }) : _quillController = quillController;

  final QuillController _quillController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: QuillToolbar.basic(
        iconTheme: QuillIconTheme(
          borderRadius: 20,
          iconUnselectedFillColor: Colors.transparent,
        ),
        color: Colors.black,
        showAlignmentButtons: false,
        showBoldButton: false,
        showSubscript: false,
        showSuperscript: false,
        showBackgroundColorButton: false,
        showCenterAlignment: false,
        showClearFormat: false,
        showCodeBlock: false,
        showColorButton: false,
        showDirection: false,
        showDividers: false,
        showFontFamily: false,
        showFontSize: false,
        showHeaderStyle: false,
        showIndent: false,
        showInlineCode: false,
        showItalicButton: false,
        showJustifyAlignment: false,
        showLeftAlignment: false,
        showLink: false,
        showListBullets: false,
        showListCheck: false,
        showListNumbers: false,
        showQuote: false,
        showRightAlignment: false,
        showSearchButton: false,
        showSmallButton: false,
        showStrikeThrough: false,
        showUnderLineButton: false,
        toolbarSectionSpacing: 13,
        toolbarIconSize: 23,
        controller: _quillController,
      ),
    );
  }
}
