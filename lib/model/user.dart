class User {
  final String firstName;
  final String email;
  final String username;
  final String? password;

  User(
      {required this.firstName,
      required this.username,
      required this.email,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      password: json['password'] != null ? json['password'] as String : '',
      username: json['username'],
      firstName: json['firstName'] != null ? json['firstName'] as String : '',
      email: json['email'],
    );
  }

  // Dart nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'email': email,
      'password': password,
      'username': username,
    };
  }
}
