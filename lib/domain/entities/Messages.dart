import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/domain/entities/User.dart';

class Messages{
  final String header, messages, image;
  final DateTime time;
  final User user;
  final Note note;

  Messages(this.header, this.messages, this.image, this.time, this.user, this.note);
}