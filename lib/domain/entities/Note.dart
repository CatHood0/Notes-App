import 'dart:convert';

class Note {
  String key;
  String title;
  String content;
  int updates;
  List<String>? tag;
  bool favorite;
  DateTime createDate;
  DateTime dateTimeModification;

  Note(
      {required this.title,
      required this.content,
      required this.createDate,
      required this.key,
      required this.favorite,
      required this.updates,
      required this.dateTimeModification,
      this.tag})
      : assert(title.isNotEmpty),
        assert(key.isNotEmpty);

  Note copyWith({
    String? key,
    String? title,
    String? content,
    List<String>? tag,
    bool? favorite,
    int? update,
    DateTime? createDate,
    DateTime? dateTimeModification,
  }) {
    return Note(
      key: key ?? this.key,
      title: title ?? this.title,
      content: content ?? this.content,
      tag: tag ?? this.tag,
      updates: update ?? this.updates,
      favorite: favorite ?? this.favorite,
      createDate: createDate ?? this.createDate,
      dateTimeModification: dateTimeModification ?? this.dateTimeModification,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'title': title,
      'content': content,
      'is_favorite': favorite,
      'createDate': createDate,
      'updates': updates,
      'date_modification': dateTimeModification,
      'tags': tag,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      key: map['key'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      tag: map['tags'] != null
          ? List<String>.from((map['tags'] as List<String>))
          : null,
      favorite: map['is_favorite'] as bool,
      createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int),
      updates: map['updates'],
      dateTimeModification:
          DateTime.fromMillisecondsSinceEpoch(map['date_modification'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note && runtimeType == other.runtimeType && key == other.key;

  @override
  int get hashCode => key.hashCode;

}
