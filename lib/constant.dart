import 'package:flutter/material.dart';
import 'package:notes_project/domain/entities/Template.dart';
import 'package:notes_project/domain/entities/User.dart';
import 'data/response/response.dart';
import 'domain/entities/Note.dart';

const primaryColor = Color(0xFF1ABC9C);
const secundaryColor = Color(0xFF1BCC9C);
const appBarColor = Color(0xFF2c3e50);
const letterColorLightTheme = Colors.black;
const letterColorDarkTheme = Colors.white;
const buttonGeneralColor = Color.fromRGBO(140, 255, 46, 1);
const double fontSizeTitles = 18.0;
const double fontSizeContent = 16;

typedef StreamNoteEither = Stream<ResponseEither<String, List<Note>>>;
typedef StreamUserEither = Stream<ResponseEither<String, User>>;
typedef StreamStoreEither = Stream<ResponseEither<String, List<Template>>>;


//Example for use share package (you must convert object note to json, then, json to file.something)
// Builder(
//   builder: (BuildContext context) {
//     return ElevatedButton(
//       onPressed: () => _onShare(context),
//           child: const Text('Share'),
//      );
//   },
// ),

// // _onShare method:
// final box = context.findRenderObject() as RenderBox?;

// await Share.share(
//   text,
//   subject: subject,
//   sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
// );