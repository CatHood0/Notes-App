import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:notes_project/domain/entities/Note.dart';
import 'package:notes_project/domain/entities/User.dart';

@immutable
class Messages extends Equatable {
  final int? id;
  final String header;
  final String messages;
  final DateTime time;
  final User? user;
  final Note? note;

  Messages(
      {this.id,
      required this.header,
      required this.messages,
      required this.time,
      required this.user,
      this.note})
      : assert(header.isNotEmpty),
        assert(messages.isNotEmpty),
        assert(user!.id! > 1);

  factory Messages.fromMap(Map<String, dynamic> map) {
    return Messages(
      id: map['id'] != null ? map['id'] as int : null,
      header: map['header'] as String,
      messages: map['messages'] as String,
      time: DateTime.parse(map['time'] as String),
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      note: map['note'] != null
          ? Note.fromMap(map['note'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'header': header,
      'messages': messages,
      'time': time.toString(),
      'user': user?.toMap(),
      'note': note?.toMap(),
    };
  }

  Messages copyWith({
    int? id,
    String? header,
    String? messages,
    DateTime? time,
    User? user,
    Note? note,
  }) {
    return Messages(
      id: id ?? this.id,
      header: header ?? this.header,
      messages: messages ?? this.messages,
      time: time ?? this.time,
      user: user ?? this.user,
      note: note ?? this.note,
    );
  }

  String toJson() => json.encode(toMap());
  factory Messages.fromJson(String source) =>
      Messages.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [user, note, messages, header];
}
