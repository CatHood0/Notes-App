// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'Note.dart';
import 'Template.dart';
import 'User.dart';

class Share {
  //we go to put this class to API
  int? id;
  String message;
  int idUserReceiveIt;
  int idUserSendIt;
  List<int?> id_notes;

  Share({
    this.id,
    required this.message,
    required this.idUserReceiveIt,
    required this.idUserSendIt,
    required this.id_notes,
  });

  Share copyWith({
    int? id,
    String? message,
    int? idUserReceiveIt,
    int? idUserSendIt,
    List<int?>? id_notes,
  }) {
    return Share(
      id: id ?? this.id,
      message: message ?? this.message,
      idUserReceiveIt: idUserReceiveIt ?? this.idUserReceiveIt,
      idUserSendIt: idUserSendIt ?? this.idUserSendIt,
      id_notes: id_notes ?? this.id_notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'idUserReceiveIt': idUserReceiveIt,
      'idUserSendIt': idUserSendIt,
      'id_notes': id_notes,
    };
  }

  factory Share.fromMap(Map<String, dynamic> map) {
    return Share(
      id: map['id'] != null ? map['id'] as int : null,
      message: map['message'] as String,
      idUserReceiveIt: map['idUserReceiveIt'] as int,
      idUserSendIt: map['idUserSendIt'] as int,
      id_notes: List<int?>.from((map['id_notes'] as List<int?>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Share.fromJson(String source) =>
      Share.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Share other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.message == message &&
        other.idUserReceiveIt == idUserReceiveIt &&
        other.idUserSendIt == idUserSendIt &&
        listEquals(other.id_notes, id_notes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        message.hashCode ^
        idUserReceiveIt.hashCode ^
        idUserSendIt.hashCode ^
        id_notes.hashCode;
  }
}

class ShareTranslator {
  //we receive this class
  final int id;
  final String message;
  final User userSend;
  final User userReceive;
  final List<Note> listNotes;
  final List<Template> listTemplates;

  ShareTranslator({
    required this.id,
    required this.message,
    required this.userSend,
    required this.userReceive,
    required this.listNotes,
    required this.listTemplates,
  });

  ShareTranslator copyWith({
    int? id,
    String? message,
    User? userSend,
    User? userReceive,
    List<Note>? listNotes,
    List<Template>? listTemplates,
  }) {
    return ShareTranslator(
      id: id ?? this.id,
      message: message ?? this.message,
      userSend: userSend ?? this.userSend,
      userReceive: userReceive ?? this.userReceive,
      listNotes: listNotes ?? this.listNotes,
      listTemplates: listTemplates ?? this.listTemplates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'userSend': userSend.toMap(),
      'userReceive': userReceive.toMap(),
      'listNotes': listNotes.map((x) => x.toMap()).toList(),
      'listTemplates': listTemplates.map((x) => x.toMap()).toList(),
    };
  }

  factory ShareTranslator.fromMap(Map<String, dynamic> map) {
    return ShareTranslator(
      id: map['id'] as int,
      message: map['message'] as String,
      userSend: User.fromMap(map['userSend'] as Map<String, dynamic>),
      userReceive: User.fromMap(map['userReceive'] as Map<String, dynamic>),
      listNotes: List<Note>.from(
        (map['listNotes'] as List<int>).map<Note>(
          (x) => Note.fromMap(x as Map<String, dynamic>),
        ),
      ),
      listTemplates: List<Template>.from(
        (map['listTemplates'] as List<int>).map<Template>(
          (x) => Template.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShareTranslator.fromJson(String source) =>
      ShareTranslator.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ShareTranslator other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.message == message &&
        other.userSend == userSend &&
        other.userReceive == userReceive &&
        listEquals(other.listNotes, listNotes) &&
        listEquals(other.listTemplates, listTemplates);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        message.hashCode ^
        userSend.hashCode ^
        userReceive.hashCode ^
        listNotes.hashCode ^
        listTemplates.hashCode;
  }
}
