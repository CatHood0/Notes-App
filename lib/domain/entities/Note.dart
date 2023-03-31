class note {
  int? key;
  String title;
  String content;
  bool favorite;
  DateTime createDate;
  DateTime dateTimeModification;

  note({
      required this.title,
      required this.content,
      required this.createDate,
      required this.key,
      required this.favorite,
      required this.dateTimeModification});

  int? get Key => key;
  String get Title => title;
  bool get Favorite => favorite;
  String get Content => content;
  DateTime get DateModification => dateTimeModification;
  DateTime get Date => createDate;

  factory note.fromJson(Map<String, dynamic> json){
    return note(
      title: json['title'], 
      content: json['content'], 
      createDate: json['createDate'], 
      key: json['key'], 
      favorite: json['isFavorite'], 
      dateTimeModification: json['date_modification'],
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
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is note && runtimeType == other.runtimeType && key == other.key;

  @override
  int get hashCode => key.hashCode;
}
