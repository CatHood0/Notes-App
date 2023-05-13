import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../enums/enums.dart';

class User extends Equatable {
  final int? id;
  final String username;
  final String avatar;
  final String email;
  final String token;
  final String encryptedPass;
  final TypeUser type;
  final TypeBan? ban;

  User({
    required this.id,
    required this.username,
    required this.avatar,
    required this.email,
    required this.encryptedPass,
    required this.token,
    required this.type,
    this.ban,
  })  : assert(id!>1),
        assert(token.isNotEmpty),
        assert(email.isNotEmpty),
        assert(username.isNotEmpty);

  User copyWith({
    int? id,
    String? username,
    String? avatar,
    String? email,
    String? token,
    String? encryptedPass,
    TypeUser? type,
    TypeBan? ban,
  }) {
    return User(
        id: id ?? this.id,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        token: token ?? this.token,
        encryptedPass: encryptedPass ?? this.encryptedPass,
        type: type ?? this.type,
        ban: ban ?? this.ban);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [id, username, email, token];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'avatar': avatar,
      'email': email,
      'token': token,
      'encryptedPass': encryptedPass,
      'type_user': type.index,
      'type_ban': ban!.index,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] as int,
        username: map['username'] as String,
        avatar: map['avatar'] as String,
        email: map['email'] as String,
        token: map['token'] as String,
        encryptedPass: map['encryptedPass'] as String,
        type: TypeUser.values[map['type_user'] as int],
        ban: TypeBan.values[map['ban'] as int]);
  }
}
