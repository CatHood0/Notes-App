import 'dart:convert';
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final int? id_user;
  final String name;
  final String content;
  final DateTime finishItTask;
  final DateTime creationDate;

  Task({
    this.id,
    this.id_user,
    required this.name,
    required this.content,
    required this.finishItTask,
    required this.creationDate,
  });

  @override
  List<Object?> get props => [id, id_user, name, content, finishItTask, creationDate];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_user': id_user,
      'name': name,
      'detail': content,
      'finish_it': finishItTask.toString(),
      'creation_date': creationDate.toString(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      id_user: map['id_user'],
      name: map['name'] as String,
      content: map['detail'] as String,
      finishItTask: DateTime.parse(map['finish_it'] as String),
      creationDate: DateTime.parse(map['creation_date'] as String),
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
      id_user: id_user,
      name: name ?? this.name,
      content: content ?? this.content,
      finishItTask: finishItTask ?? this.finishItTask,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
