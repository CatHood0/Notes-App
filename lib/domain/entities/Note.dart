import 'dart:convert';

class Note {
  final int? key;
  final int? id_folder;
  final int? id_user;
  final String title;
  final String? password;
  final String content;
  final String readable;
  final double lastScroll;
  final bool favorite;
  final DateTime createDate;
  final DateTime dateTimeModification;

  Note({
    required this.title,
    required this.content,
    required this.readable,
    required this.createDate,
    required this.favorite,
    required this.dateTimeModification,
    this.id_folder,
    this.id_user,
    this.key,
    this.lastScroll = 0.0,
    this.password
  }) : assert(title.isNotEmpty);

  Note copyWith({
    int? key,
    int? update,
    int? id_folder,
    int? id_user,
    double? last,
    String? title,
    String? content,
    String? readable,
    String? password,
    bool? pin,
    bool? favorite,
    DateTime? createDate,
    DateTime? dateTimeModification,
  }) {
    return Note(
      key: key ?? this.key,
      id_folder: id_folder ?? this.id_folder,
      id_user: id_user ?? this.id_user,
      title: title ?? this.title,
      content: content ?? this.content,
      readable: readable ?? this.readable,
      password: password ?? this.password,
      favorite: favorite ?? this.favorite,
      createDate: createDate ?? this.createDate,
      lastScroll: last ?? this.lastScroll,
      dateTimeModification: dateTimeModification ?? this.dateTimeModification,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_folder': id_folder,
      'id_user': id_user,
      'title': title,
      'content': content,
      'plain_content': readable,
      'favorite': favorite == true ? 1 : 0,
      'create_date': createDate.toString(),
      'modification_date': dateTimeModification.toString(),
      'last_position': lastScroll,
      'password': password,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      key: map['id'] as int,
      id_folder: map['id_folder'],
      id_user: map['id_user'],
      title: map['title'] as String,
      content: map['content'] as String,
      readable: map['plain_content'] as String,
      favorite: map['favorite'] == 1 ? true : false,
      createDate: DateTime.parse(map['create_date'] as String),
      dateTimeModification: DateTime.parse(map['modification_date'] as String),
      lastScroll: map['last_position'] ?? 0.0,
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
