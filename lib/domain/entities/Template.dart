import 'dart:convert';

class Template {
  final int id;
  final int id_user; 
  final String name;
  final String content;
  final makePublic;
  final int likes;
  final int shares;

  Template( 
      {required this.id,
      required this.id_user,
      required this.name,
      required this.content,
      required this.likes,
      required this.shares,
      this.makePublic = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'content': content,
      'likes': likes,
      'shares': shares,
    };
  }

  factory Template.fromMap(Map<String, dynamic> map) {
    return Template(
      id: map['id'] as int,
      id_user: map['id_user'] as int,
      name: map['name'] as String,
      content: map['content'] as String,
      likes: map['likes'] as int,
      makePublic: map['public'] as bool,
      shares: map['share'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Template.fromJson(String source) => Template.fromMap(json.decode(source) as Map<String, dynamic>);

  Template copyWith({
    int? id,
    int? idUser, 
    String? name,
    String? content,
    int? likes,
    int? shares,
  }) {
    return Template(
      id: id ?? this.id,
      id_user: idUser = this.id_user,
      name: name ?? this.name,
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
        other.runtimeType == this.runtimeType;
  }

  @override
  int get hashCode {
    return id.hashCode ^ content.hashCode ^ name.hashCode;
  }
}
