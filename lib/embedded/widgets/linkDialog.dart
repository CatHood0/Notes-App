import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/translations.dart';

class LinkDialog extends StatefulWidget {
  const LinkDialog({this.dialogTheme, this.link, Key? key}) : super(key: key);

  final QuillDialogTheme? dialogTheme;
  final String? link;

  @override
  LinkDialogState createState() => LinkDialogState();
}

class LinkDialogState extends State<LinkDialog> {
  late String _link;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _link = widget.link ?? '';
    _controller = TextEditingController(text: _link);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.dialogTheme?.dialogBackgroundColor,
      content: TextField(
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: widget.dialogTheme?.inputTextStyle,
        decoration: InputDecoration(
            labelText: 'Paste a link'.i18n,
            labelStyle: widget.dialogTheme?.labelTextStyle,
            floatingLabelStyle: widget.dialogTheme?.labelTextStyle),
        autofocus: true,
        onChanged: _linkChanged,
        controller: _controller,
      ),
      actions: [
        TextButton(
          onPressed: _link.isNotEmpty &&
                  AutoFormatMultipleLinksRule.linkRegExp.hasMatch(_link)
              ? _applyLink
              : null,
          child: Text(
            'Ok'.i18n,
            style: widget.dialogTheme?.labelTextStyle,
          ),
        ),
      ],
    );
  }

  void _linkChanged(String value) {
    setState(() {
      _link = value;
    });
  }

  void _applyLink() {
    Navigator.pop(context, _link.trim());
  }
}

