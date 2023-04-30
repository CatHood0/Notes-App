import 'package:flutter/material.dart';
import 'package:notes_project/domain/entities/Template.dart';
import 'package:notes_project/domain/entities/User.dart';
import 'package:timeago/timeago.dart';
import 'data/response/response.dart';
import 'domain/entities/Note.dart';
import 'enums.dart';

const primaryColor = Color(0xFFefc3ff);
const secundaryColor = Color(0xFFd7c3ff);
const appBarColor = Color(0xFF2c3e50);
const letterColorLightTheme = Colors.black;
const letterColorDarkTheme = Colors.white;
const buttonGeneralColor = Color.fromARGB(255, 255, 171, 255);
const double fontSizeTitles = 18.0;
const double fontSizeContent = 16;

typedef StreamNoteEither = Stream<ResponseEither<String, List<Note>>>;
typedef StreamUserEither = Stream<ResponseEither<String, User>>;
typedef StreamStoreEither = Stream<ResponseEither<String, List<Template>>>;

class MyCustomMessages implements LookupMessages {
  @override String prefixAgo() => '';
  @override String prefixFromNow() => '';
  @override String suffixAgo() => '';
  @override String suffixFromNow() => '';
  @override String lessThanOneMinute(int seconds) => 'just now';
  @override String aboutAMinute(int minutes) => '${minutes} moment';
  @override String minutes(int minutes) => '${minutes} min';
  @override String aboutAnHour(int minutes) => '${minutes} min';
  @override String hours(int hours) => '${hours} hour';
  @override String aDay(int hours) => '${hours} hours';
  @override String days(int days) => '${days} day';
  @override String aboutAMonth(int days) => '${days} days';
  @override String months(int months) => '${months} month';
  @override String aboutAYear(int year) => '${year} month';
  @override String years(int years) => '${years} year';
  @override String wordSeparator() => ' ';
}

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