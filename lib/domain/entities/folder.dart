import 'dart:convert';

class Folder {
  int? id;
  String name;
  String descriptionFolder;
  String? password;
  bool isPin;
  DateTime creation;
  Folder({
    this.id,
    required this.name,
    required this.descriptionFolder,
    required this.isPin,
    this.password,
    required this.creation,
  });

  Folder copyWith({
    int? id,
    String? name,
    String? descriptionFolder,
    bool? pin,
    String? password,
    DateTime? creation,
  }) {
    return Folder(
      id: id ?? this.id,
      name: name ?? this.name,
      isPin: pin ?? this.isPin, 
      descriptionFolder: descriptionFolder ?? this.descriptionFolder,
      password: password ?? this.password,
      creation: creation ?? this.creation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'descriptionFolder': descriptionFolder,
      'password': password,
      'pinned': isPin==true ? 1 : 0,
      'creation': creation.millisecondsSinceEpoch,
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'] as int,
      name: map['name'] as String,
      isPin: map['pinned']==1 ? true : false,
      descriptionFolder: map['descriptionFolder'] as String,
      password: map['password'] as String,
      creation: DateTime.parse(map['creation'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Folder.fromJson(String source) =>
      Folder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Folder other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
