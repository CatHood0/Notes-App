// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final String name;
  final String content;
  final DateTime finishItTask;
  final DateTime creationDate;

  Task({
    this.id,
    required this.name,
    required this.content,
    required this.finishItTask,
    required this.creationDate,
  });

  @override
  List<Object?> get props => [id, name, content, finishItTask, creationDate];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'content': content,
      'finishItTask': finishItTask.toString(),
      'creationDate': creationDate.toString(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'] as String,
      content: map['content'] as String,
      finishItTask: DateTime.parse(map['finishItTask'] as String),
      creationDate: DateTime.parse(map['creationDate'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);

  Task copyWith({
    int? id,
    String? name,
    String? content,
    DateTime? finishItTask,
    DateTime? creationDate,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      finishItTask: finishItTask ?? this.finishItTask,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
