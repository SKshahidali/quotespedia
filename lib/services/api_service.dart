import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quotespedia/models/quotes_model.dart';

class QuoteService {
  final String apiKey = "NzU8qCT0iAfJ/MBbOw323A==7yPCfRvRwW8ezzbo";

  Future<List<QuotesPedia>> fetchQuotes(String category) async {
    final String url = "https://api.api-ninjas.com/v1/quotes?category=";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => QuotesPedia.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load quotes. Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
