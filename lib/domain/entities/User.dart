class User {
  int id;
  String username;
  String avatar;
  String email;
  String token;
  String encryptedPass;

  User(
      {required this.id,
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
}
