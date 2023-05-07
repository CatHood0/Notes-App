// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:notes_project/domain/enums/enums.dart';
import 'package:notes_project/domain/translators/translator.dart';

class Issue extends Equatable{
  final int? id;
  final int id_user;
  final TypeReason reason;
  final String description;
  final String image;

  Issue({
    this.id,
    required this.id_user,
    required this.reason,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'id_user': id_user,
      'reason': reason.name,
      'description': description,
      'image': image,
    };
  }

  factory Issue.fromMap(Map<String, dynamic> map) {
    return Issue(
      id: map['id'] != null ? map['id'] as int : null,
      id_user: map['id_user'] as int,
      reason: Translator.translateIssue(map['reason'] as String),
      description: map['description'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Issue.fromJson(String source) =>
      Issue.fromMap(json.decode(source) as Map<String, dynamic>);

  Issue copyWith({
    int? id,
    int? id_user,
    TypeReason? reason,
    String? description,
    String? image,
  }) {
    return Issue(
      id: id ?? this.id,
      id_user: id_user ?? this.id_user,
      reason: reason ?? this.reason,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
  
  @override
  List<Object?> get props => [id, id_user, reason, description];
}
