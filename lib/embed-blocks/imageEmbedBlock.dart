import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart' as base;
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/translations.dart';
import 'package:flutter_quill_extensions/embeds/widgets/image.dart';
import 'package:flutter_quill_extensions/embeds/widgets/image_resizer.dart';

class ImageEmbedBuilder extends EmbedBuilder {
  @override
  String get key => BlockEmbed.imageType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    base.Embed node,
    bool readOnly,
    bool inline,
  ) {
    var image;
    final imageUrl = standardizeImageUrl(node.value.data);
    OptionalSize? _imageSize; //for resize images

    //Is HTML?
    final style = node.style.attributes['style'];
    if (base.isMobile() && style != null) {
      final _attrs = base.parseKeyValuePairs(style.value.toString(), {
        Attribute.mobileWidth,
        Attribute.mobileHeight,
        Attribute.mobileMargin,
        Attribute.mobileAlignment
      });
      if (_attrs.isNotEmpty) {
        assert(
            _attrs[Attribute.mobileWidth] != null &&
                _attrs[Attribute.mobileHeight] != null,
            'mobileWidth and mobileHeight must be specified');
        final width = double.parse(_attrs[Attribute.mobileWidth]!);
        final height = double.parse(_attrs[Attribute.mobileHeight]!);
        _imageSize = OptionalSize(width, height);
        final margin = _attrs[Attribute.mobileMargin] == null
            ? 0.0
            : double.parse(_attrs[Attribute.mobileMargin]!);
        final align = base.getAlignment(_attrs[Attribute.mobileAlignment]);
        image = Padding(
            padding: EdgeInsets.all(margin),
            child: imageByUrl(imageUrl, width: width, height: height, alignment: align));
      }
    }

    //if not html, then...
    if (_imageSize == null) {
      image = imageByUrl(imageUrl);
      _imageSize = OptionalSize((image as Image).width, image.height);
    }
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                final resizeOption = _SimpleDialogItem(
                  icon: Icons.restart_alt_outlined,
                  color: Colors.lightBlueAccent,
                  text: 'Resize'.i18n,
                  onPressed: () {
                    Navigator.pop(context);
                    showCupertinoModalPopup<void>(
                        context: context,
                        builder: (context) {
                          final _screenSize = MediaQuery.of(context).size;
                          return ImageResizer(
                              onImageResize: (width, height) {
                                final res = getEmbedNode(
                                    controller, controller.selection.start);
                                final attr = base.replaceStyleString(
                                    getImageStyleString(controller),
                                    width,
                                    height);
                                controller
                                  ..skipRequestKeyboard = true
                                  ..formatText(
                                      res.offset, 1, StyleAttribute(attr));
                              },
                              imageWidth: _imageSize?.width,
                              imageHeight: _imageSize?.height,
                              maxWidth: _screenSize.width,
                              maxHeight: _screenSize.height);
                        });
                  },
                );
                final copyOption = _SimpleDialogItem(
                  icon: Icons.bookmarks_outlined,
                  color: Colors.cyanAccent,
                  text: 'Copy'.i18n,
                  onPressed: () {
                    final imageNode =
                        getEmbedNode(controller, controller.selection.start)
                            .value;
                    final imageUrl = imageNode.value.data;
                    controller.copiedImageUrl =
                        ImageUrl(imageUrl, getImageStyleString(controller));
                    Navigator.pop(context);
                  },
                );
                final removeOption = _SimpleDialogItem(
                  icon: Icons.delete_forever_outlined,
                  color: Colors.red.shade200,
                  text: 'Remove'.i18n,
                  onPressed: () {
                    final offset =
                        getEmbedNode(controller, controller.selection.start)
                            .offset;
                    controller.replaceText(
                        offset, 1, '', TextSelection.collapsed(offset: offset));
                    Navigator.pop(context);
                  },
                );
                return Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: SimpleDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      children: [resizeOption, copyOption, removeOption]),
                );
              });
        },
        child: image);
  }
}

class _SimpleDialogItem extends StatelessWidget {
  const _SimpleDialogItem(
      {required this.icon,
      required this.color,
      required this.text,
      required this.onPressed,
      Key? key})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(icon, size: 36, color: color),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child:
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
