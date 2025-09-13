import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  /// POST request (for login or other APIs)
  static Future<Map<String, dynamic>> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 400) {
        throw Exception("Bad Request: ${response.body}");
      } else {
        throw Exception(
            "POST request failed (Status ${response.statusCode}): ${response.body}");

      }
    } catch (e) {
      throw Exception("POST request error: $e");
    }
  }

  /// GET request (for fetching articles, etc.)
  static Future<List<dynamic>> getRequest(String endpoint,
      {int? start, int? limit}) async {
    try {
      String url = "$baseUrl/$endpoint";

      // Add pagination query parameters if provided
      if (start != null && limit != null) {
        url += "?_start=$start&_limit=$limit";
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw Exception(
            "GET request failed (Status ${response.statusCode}): ${response.body}");
      }
    } catch (e) {
      throw Exception("GET request error: $e");
    }
  }
}
