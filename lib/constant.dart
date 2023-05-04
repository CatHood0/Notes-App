import 'package:flutter/material.dart';
import 'package:notes_project/domain/entities/Template.dart';
import 'package:notes_project/domain/entities/User.dart';
import 'package:timeago/timeago.dart';
import 'data/response/response.dart';
import 'domain/entities/Note.dart';

const primaryColor = Color(0xFFefc3ff);
const secundaryColor = Color.fromARGB(255, 225, 143, 255);
const appBarColor = Color(0xFF2c3e50);
const letterColorLightTheme = Colors.black;
const letterColorDarkTheme = Colors.white;
const buttonGeneralColor = Color.fromARGB(255, 255, 171, 255);
const double fontSizeTitles = 18.0;
const double fontSizeContent = 16;
const supabaseUrl = 'https://moqyeplsnwyhtekqdisw.supabase.co';
const supabaseKey = String.fromEnvironment(
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1vcXllcGxzbnd5aHRla3FkaXN3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODI5MzcxMDIsImV4cCI6MTk5ODUxMzEwMn0.muS-QSw05hNAESfJ2v-bqQIqzQSCfcWVqyI8tmuQzL0');

typedef StreamNoteEither = Stream<ResponseEither<String, List<Note>>>;
typedef StreamUserEither = Stream<ResponseEither<String, User>>;
typedef StreamStoreEither = Stream<ResponseEither<String, List<Template>>>;

final Map<String, String> fontFamilyOptions = {
  'Arial': 'Arial',
  'Times New Roman': 'Times New Roman',
  'Monospace': 'Monospace',
};

class MyCustomMessages implements LookupMessages {
  @override String prefixAgo() => '';
  @override String prefixFromNow() => '';
  @override String suffixAgo() => '';
  @override String suffixFromNow() => '';
  @override String lessThanOneMinute(int seconds) => 'just now';
  @override String aboutAMinute(int minutes) => '${minutes} moment ago';
  @override String minutes(int minutes) => '${minutes} min ago';
  @override String aboutAnHour(int minutes) => 'an hour ago';
  @override String hours(int hours) => '${hours} hours ago';
  @override String aDay(int hours) => 'a day ago';
  @override String days(int days) => '$days days ago';
  @override String aboutAMonth(int days) => '${days} days ago';
  @override String months(int months) => '${months} month ago';
  @override String aboutAYear(int year) => '${year} year ago';
  @override String years(int years) => '${years} years ago';
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