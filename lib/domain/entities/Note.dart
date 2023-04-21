class note {
  String key;
  String title;
  String? content;
  List<String>? tag;
  bool favorite;
  DateTime createDate;
  DateTime dateTimeModification;

  note({
      required this.title,
      required this.content,
      required this.createDate,
      required this.key,
      required this.favorite,
      required this.dateTimeModification,
      this.tag
      }) : assert(title.isNotEmpty);

  factory note.fromJson(Map<String, dynamic> json){
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
      'key': this.key,
      'title': this.title,
      'content': this.content,
      'isFavorite': this.favorite,
      'createDate': this.createDate,
      'date_modification': this.dateTimeModification,
      'tags': this.tag,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is note && runtimeType == other.runtimeType && key == other.key;

  @override
  int get hashCode => key.hashCode;
}
