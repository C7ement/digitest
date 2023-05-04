import 'dart:convert';

import 'package:digitest/api_keys.dart';
import 'package:http/http.dart' as http;

class UnsplashRepository {
  final String _baseUrl = 'https://api.unsplash.com';
  final String _apiKey = ApiKeys.accessKey;

  Future<List<String>> fetchImages({required int count, String? query}) async {
    final queryParams = {'client_id': _apiKey, 'count': count.toString()};
    if (query != null) {
      queryParams['query'] = query;
    }
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/photos/random?' + _encodeQueryParameters(queryParams)),
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

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }
}
