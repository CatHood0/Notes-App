import 'package:flutter/material.dart';
import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/domain/entities/Template.dart';
import 'package:notes_project/domain/entities/User.dart';
import 'data/response/response.dart';

final primaryColor = Color(0xFF1ABC9C);
final secundaryColor = Color(0xFF1BCC9C);
final appBarColor = Color(0xFF2c3e50);
final letterColorLightTheme = Colors.black;
final letterColorDarkTheme = Colors.white;
final buttonGeneralColor = Color.fromRGBO(140, 255, 46, 1);
final double fontSizeTitles = 18.0;
final double fontSizeContent = 16;
typedef StreamNoteEither = Stream<Response<String, note>>;
typedef FutureUserEither = Stream<Response<String, User>>;
typedef StreamStoreEither = Stream<Response<String, Template>>;
