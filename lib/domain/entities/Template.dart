import 'dart:convert';
import 'package:equatable/equatable.dart';

class Template {
  final String id;
  final String content;
  final makePublic;
  final int likes;
  final int shares;

  Template(
      {required this.id,
      required this.content,
      required this.likes,
      required this.shares,
      this.makePublic = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'likes': likes,
      'shares': shares,
    };
  }

  factory Template.fromMap(Map<String, dynamic> map) {
    return Template(
      id: map['id'] as String,
      content: map['content'] as String,
      likes: map['likes'] as int,
      makePublic: map['public'] as bool,
      shares: map['share'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Template.fromJson(String source) => Template.fromMap(json.decode(source) as Map<String, dynamic>);

  Template copyWith({
    String? id,
    String? content,
    int? likes,
    int? shares,
  }) {
    return Template(
      id: id ?? this.id,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      shares: shares ?? this.shares,
    );
  }

  @override
  bool operator ==(covariant Template other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.content == content &&
        other.likes == likes &&
        other.shares == shares;
  }

  @override
  int get hashCode {
    return id.hashCode ^ content.hashCode ^ likes.hashCode ^ shares.hashCode;
  }
}
