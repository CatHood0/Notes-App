import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/embeds/embed_types.dart';
import 'package:notes_project/embed-blocks/widgets/imageButtonEditor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../constant.dart';
import '../../../../embed-blocks/widgets/videoButtonEditor.dart';

class QuillToolBarEditorWidget extends StatelessWidget {
  const QuillToolBarEditorWidget({
    super.key,
    required this.quillController,
    required this.oldController,
  });
  final QuillController quillController;
  final QuillController oldController;

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
      controller: quillController,
      multiRowsDisplay: false,
      embedButtons: embedButtons(
        imageButtonTooltip: 'image',
        oldController: oldController,
        onImagePickCallback: _onImagePickCallback,
        mediaPickSettingSelector: (context) async =>
            await MediaPickSetting.Gallery,
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

List<EmbedButtonBuilder> embedButtons({
  bool showImageButton = true,
  bool showVideoButton = true,
  required QuillController oldController,
  String? videoButtonTooltip,
  String? imageButtonTooltip,
  OnImagePickCallback? onImagePickCallback,
  MediaPickSettingSelector? mediaPickSettingSelector,
}) =>
    [
      if (showImageButton)
        (controller, toolbarIconSize, iconTheme, dialogTheme) => ImageButton(
              icon: Icons.image,
              iconSize: toolbarIconSize,
              tooltip: imageButtonTooltip,
              controller: controller,
              oldController: oldController,
              onImagePickCallback: onImagePickCallback,
              mediaPickSettingSelector: mediaPickSettingSelector,
              iconTheme: iconTheme,
              dialogTheme: dialogTheme,
            ),
      if (showVideoButton)
        (controller, toolbarIconSize, iconTheme, dialogTheme) => VideoButton(
              icon: Icons.movie_rounded,
              iconSize: toolbarIconSize,
              tooltip: videoButtonTooltip,
              controller: controller,
              iconTheme: iconTheme,
              dialogTheme: dialogTheme,
            ),
    ];
