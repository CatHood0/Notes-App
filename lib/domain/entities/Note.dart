import 'dart:convert';
class Note {
  int? key;
  int updates;
  String title;
  String content;
  String? tag;
  double? lastScroll;
  bool favorite;
  DateTime createDate;
  DateTime dateTimeModification;

  Note(
      {required this.title,
      required this.content,
      required this.createDate,
      required this.favorite,
      required this.updates,
      required this.dateTimeModification,
      this.tag,
      this.key,
      this.lastScroll,
      })
      : assert(title.isNotEmpty);

  Note copyWith({
    int? key,
    int? update,
    double? last,
    String? title,
    String? content,
    String? tag,
    bool? pin,
    bool? favorite,
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
      lastScroll: last ?? this.lastScroll, 
      dateTimeModification: dateTimeModification ?? this.dateTimeModification,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'favorite': favorite==true ? 1 : 0,
      'create_date': createDate.toString(),
      'updates': updates,
      'modification_date': dateTimeModification.toString(),
      'tag': tag,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      key: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      tag: map['tag'],
      favorite: map['favorite']==1 ? true : false,
      createDate: DateTime.parse(map['create_date'] as String),
      updates: map['updates'],
      dateTimeModification: DateTime.parse(map['modification_date'] as String),
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
