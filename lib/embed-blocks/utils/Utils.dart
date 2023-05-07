import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/translations.dart';
import 'package:flutter_quill_extensions/embeds/embed_types.dart';
import 'package:image_picker/image_picker.dart';

class ImageAndVideoUtils {
  //decide which one will use it
  static Future<MediaPickSetting?> selectMediaPickSetting(
    BuildContext context,
  ) =>
      showDialog<MediaPickSetting>(
        context: context,
        builder: (ctx) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                icon: const Icon(
                  Icons.collections,
                  color: Colors.orangeAccent,
                ),
                label: Text('Gallery'.i18n),
                onPressed: () => Navigator.pop(ctx, MediaPickSetting.Gallery),
              ),
              TextButton.icon(
                icon: const Icon(
                  Icons.link,
                  color: Colors.cyanAccent,
                ),
                label: Text('Link'.i18n),
                onPressed: () => Navigator.pop(ctx, MediaPickSetting.Link),
              )
            ],
          ),
        ),
      );

  ///image picking logic
  static Future<void> handleImageButtonTap(
    BuildContext context,
    QuillController controller,
    ImageSource imageSource,
    OnImagePickCallback onImagePickCallback,
  ) async {
    final index = controller.selection.baseOffset;
    final length = controller.selection.extentOffset - index;

    String? imageUrl;

    imageUrl = await _pickImage(imageSource, onImagePickCallback);

    if (imageUrl != null) {
      controller.replaceText(index, length, BlockEmbed.image(imageUrl), null);
    }
  }

  static Future<String?> _pickImage(
      ImageSource source, OnImagePickCallback onImagePickCallback) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) {
      return null;
    }

    return onImagePickCallback(File(pickedFile.path));
  }

  /// video picking logic
  static Future<void> handleVideoButtonTap(
      BuildContext context,
      QuillController controller,
      ImageSource videoSource,
      OnVideoPickCallback onVideoPickCallback) async {
    final index = controller.selection.baseOffset;
    final length = controller.selection.extentOffset - index;

    String? videoUrl;
    videoUrl = await _pickVideo(videoSource, onVideoPickCallback);
    if (videoUrl != null) {
      controller.replaceText(index, length, BlockEmbed.video(videoUrl), null);
    }
  }

  static Future<String?> _pickVideo(
      ImageSource source, OnVideoPickCallback onVideoPickCallback) async {
    final pickedFile = await ImagePicker().pickVideo(source: source);
    if (pickedFile == null) {
      return null;
    }

    return onVideoPickCallback(File(pickedFile.path));
  }
}
