class note {
  String key;
  String title;
  String content;
  List<String>? tag;
  bool favorite;
  DateTime createDate;
  DateTime dateTimeModification;

  note(
      {required this.title,
      required this.content,
      required this.createDate,
      required this.key,
      required this.favorite,
      required this.dateTimeModification,
      this.tag})
      : assert(title.isNotEmpty);

  factory note.fromJson(Map<String, dynamic> json) {
    return note(
      title: json['title'],
      content: json['content'],
      createDate: json['createDate'],
      key: json['key'],
      favorite: json['isFavorite'],
      dateTimeModification: json['date_modification'],
      tag: json['tags'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'title': title,
      'content': content,
      'isFavorite': favorite,
      'createDate': createDate,
      'date_modification': dateTimeModification,
      'tags': tag,
    };
  }

  Map<String, dynamic> toJsonContent() {
    return {
      'content': content,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is note && runtimeType == other.runtimeType && key == other.key;

  @override
  int get hashCode => key.hashCode;
}
