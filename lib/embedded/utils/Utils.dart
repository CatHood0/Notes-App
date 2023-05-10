import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/embeds/embed_types.dart';
import 'package:image_picker/image_picker.dart';
import '../../UI/notes/controller/NoteController.dart';
import 'dart:io';
import 'package:notes_project/main.dart';

class ImageAndVideoUtils {

  static Future<void> handleImageButtonTap(
    BuildContext context,
    QuillController controller,
    QuillController oldController,
    ImageSource imageSource,
    OnImagePickCallback onImagePickCallback,
  ) async {
    final index = controller.selection.baseOffset;
    final length = controller.selection.extentOffset - index;

    String? imageUrl;

    imageUrl = await _pickImage(imageSource, onImagePickCallback);

    if (imageUrl != null) {
      //here we put the logic for upload the image to cloud storage
      
      controller.replaceText(index, length, BlockEmbed.image(imageUrl), null);

      locator.Get<NoteController>()
          .compare(newController: controller, oldController: oldController);
      oldController.clear();
      oldController.document = Document.fromJson(controller.document.toDelta().toJson());
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
