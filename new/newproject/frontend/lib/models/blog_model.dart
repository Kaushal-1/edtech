// lib/models/blog_model.dart

class Blog {
  String id;
  String title;
  String content;
  String author;
  DateTime createdAt;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
  });

  // Factory constructor to create a Blog from JSON
  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Method to convert Blog object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'author': author,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
