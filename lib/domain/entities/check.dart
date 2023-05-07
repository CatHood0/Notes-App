import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Check extends Equatable {
  final int? id;
  final int updates;
  final String name;
  final String content;
  final DateTime createDate;
  final DateTime updateDate;

  Check({
    this.id,
    required this.updates,
    required this.name,
    required this.content,
    required this.createDate,
    required this.updateDate,
  });

  Check copyWith({
    int? id,
    int? updates,
    String? name,
    String? description,
    String? content,
    DateTime? createDate,
    DateTime? updateDate,
  }) {
    return Check(
      id: id ?? this.id,
      updates: updates ?? this.updates,
      name: name ?? this.name,
      content: content ?? this.content,
      createDate: createDate ?? this.createDate,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'updates': updates,
      'name': name,
      'content': content,
      'createDate': createDate.toString(),
      'updateDate': updateDate.toString(),
    };
  }

  factory Check.fromMap(Map<String, dynamic> map) {
    return Check(
      id: map['id'] as int,
      updates: map['updates'] as int,
      name: map['name'] as String,
      content: map['content'] as String,
      createDate: DateTime.parse(map['createDate'] as String),
      updateDate: DateTime.parse(map['updateDate'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Check.fromJson(String source) =>
      Check.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props =>
      [id, name, content, createDate, updateDate];
}
