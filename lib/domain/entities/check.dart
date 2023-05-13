import 'dart:convert';
import 'package:equatable/equatable.dart';

class Check extends Equatable {
  final int? id;
  final int? id_user;
  final String name;
  final String content;//encoded json
  final String readeable;//text plain from the encoded json
  final bool complete;
  final DateTime createDate;
  final DateTime updateDate;

  Check({
    this.id,
    this.id_user,
    required this.readeable,
    required this.complete,
    required this.name,
    required this.content,
    required this.createDate,
    required this.updateDate,
  });

  Check copyWith({
    int? id,
    int? id_user,
    String? readeable,
    String? name,
    String? description,
    String? content,
    DateTime? createDate,
    DateTime? updateDate,
    bool? complete,
  }) {
    return Check(
      id: id ?? this.id,
      id_user: id_user ?? this.id_user,
      readeable: readeable ?? this.readeable,
      name: name ?? this.name,
      content: content ?? this.content,
      createDate: createDate ?? this.createDate,
      updateDate: updateDate ?? this.updateDate,
      complete: complete ?? this.complete
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': null,
      'name': name,
      'content': content,
      'plain_content': readeable,
      'create_date': createDate.toString(),
      'modification_date': updateDate.toString(),
      'complete': complete ? 1 : 0,
    };
  }

  factory Check.fromMap(Map<String, dynamic> map) {
    return Check(
      id: map['id'] as int,
      id_user: map['id_user'] as int,
      readeable: map['plain_content'] as String,
      name: map['name'] as String,
      content: map['content'] as String,
      createDate: DateTime.parse(map['create_date'] as String),
      updateDate: DateTime.parse(map['modification_date'] as String),
      complete: map['complete']==1 ? true : false,
    );
  }

  String toJson() => json.encode(toMap());


  factory Check.fromJson(String source) =>
      Check.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props =>
      [id, name, content, createDate, updateDate];
}
