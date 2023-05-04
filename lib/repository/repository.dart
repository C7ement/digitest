import 'dart:convert';

import 'package:digitest/api_keys.dart';
import 'package:http/http.dart' as http;

class UnsplashRepository {
  final String _baseUrl = 'https://api.unsplash.com';
  final String _apiKey = ApiKeys.accessKey;

  Future<List<String>> fetchImages(int count) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/photos/random?client_id=$_apiKey&count=$count'),
    );
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      final imageUrls = jsonList
          .map<String>((json) => json['urls']['regular'] as String)
          .toList();
      return imageUrls;
    } else {
      throw Exception('Failed to load images');
    }
  }
}
