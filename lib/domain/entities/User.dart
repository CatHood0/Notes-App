// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String username;
  final String avatar;
  final String email;
  final String token;
  final String encryptedPass;

  User({required this.id,
      required this.username,
      required this.avatar,
      required this.email,
      required this.encryptedPass,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        avatar: json['avatar'],
        email: json['email'],
        encryptedPass: json['password'],
        token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'username': this.username,
      'avatar': this.avatar,
      'password': this.encryptedPass,
      'email': this.email,
      'token': this.token,
    };
  }
  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
    return 
      other.id == id &&
      other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      username.hashCode ^
      email.hashCode;
  }

  User copyWith({
    String? id,
    String? username,
    String? avatar,
    String? email,
    String? token,
    String? encryptedPass,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      token: token ?? this.token,
      encryptedPass: encryptedPass ?? this.encryptedPass,
    );
  }
}
