class Post {
  final int id;
  final String title;
  final String summary;
  final String content;
  final String author;
  final String createdAt;

  Post({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.author,
    required this.createdAt,
  });

  // For list view
  factory Post.fromListJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      summary: json['summary'],
      content: '',
      author: '',
      createdAt: json['created_at'],
    );
  }

  // For detail view
  factory Post.fromDetailJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      summary: '',
      content: json['content'],
      author: json['author'],
      createdAt: json['created_at'],
    );
  }
}
