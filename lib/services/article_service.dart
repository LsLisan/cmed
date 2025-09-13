import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class ArticleService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Article>> fetchArticles(int page, int limit) async {
    final response = await http
        .get(Uri.parse('$baseUrl/posts?_page=$page&_limit=$limit'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load articles");
    }
  }
}
