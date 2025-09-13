class Article {
  final int id;
  final String title;
  final String body;
  final int userId;
  final String? downloadUrl;

  Article({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    this.downloadUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['userId'] as int,
      downloadUrl: json['downloadUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
      'downloadUrl': downloadUrl,
    };
  }
}
