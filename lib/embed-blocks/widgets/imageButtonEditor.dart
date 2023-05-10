import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/embeds/embed_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_project/embed-blocks/utils/Utils.dart';

import 'linkDialog.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    required this.icon,
    required this.controller,
    required this.oldController,
    this.iconSize = kDefaultIconSize,
    this.onImagePickCallback,
    this.fillColor,
    this.mediaPickSettingSelector,
    this.iconTheme,
    this.dialogTheme,
    this.tooltip,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;

  final Color? fillColor;

  final QuillController controller;

  final QuillController oldController;

  final OnImagePickCallback? onImagePickCallback;

  final MediaPickSettingSelector? mediaPickSettingSelector;

  final QuillIconTheme? iconTheme;

  final QuillDialogTheme? dialogTheme;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final iconColor = iconTheme?.iconUnselectedColor ?? theme.iconTheme.color;
    final iconFillColor =
        iconTheme?.iconUnselectedFillColor ?? (fillColor ?? theme.canvasColor);

    return QuillIconButton(
      icon: Icon(icon, size: iconSize, color: iconColor),
      tooltip: tooltip,
      highlightElevation: 0,
      hoverElevation: 0,
      size: iconSize * 1.77,
      fillColor: iconFillColor,
      borderRadius: iconTheme?.borderRadius ?? 2,
      onPressed: () => _pickImage(context),
    );
  }

  void _pickImage(BuildContext context) =>
      ImageAndVideoUtils.handleImageButtonTap(
        context,
        controller,
        oldController,
        ImageSource.gallery,
        onImagePickCallback!,
      );
}
