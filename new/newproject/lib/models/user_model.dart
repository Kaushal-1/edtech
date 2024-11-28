// lib/models/user_model.dart

class User {
  String id;
  String name;
  String email;
  String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  // Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }

  // Method to convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }
}
