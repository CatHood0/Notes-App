class Template {
  final int id;
  final String content;

  Template({required this.id, required this.content});

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      id: json['key'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return ({
      'key': this.id,
      'content': this.content,
    });
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Template && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
