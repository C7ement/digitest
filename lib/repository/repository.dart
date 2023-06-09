import 'dart:convert';

import 'package:digitest/api_keys.dart';
import 'package:digitest/models/pet.dart';
import 'package:http/http.dart' as http;

class UnsplashRepository {
  final String _baseUrl = 'https://api.unsplash.com';
  final String _apiKey = ApiKeys.accessKey;

  Future<List<Pet>> fetchPets({required int count, String? query}) async {
    final queryParams = {
      'client_id': _apiKey,
      'count': count.toString(),
      'description': true,
    };

    if (query != null) {
      queryParams['query'] = 'cute $query';
    }

    final response = await http.get(
      Uri.parse(
        '$_baseUrl/photos/random?${_encodeQueryParameters(queryParams)}',
      ),
    );

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      final pets = jsonList
          .map<Pet>(
            (json) => Pet(
              category: query ?? "",
              url: json['urls']['regular'] as String,
              creationDate: DateTime.parse(
                json['created_at'] as String,
              ),
              description: json['description'] as String? ?? "",
              alt_description: json['alt_description'] as String? ?? "",
            ),
          )
          .toList();
      return pets;
    } else {
      throw Exception('Failed to load pets ${response.body}');
    }
  }

  String _encodeQueryParameters(Map<String, dynamic> params) {
    return params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }
}
