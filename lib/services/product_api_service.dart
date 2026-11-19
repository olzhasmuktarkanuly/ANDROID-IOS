import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ProductApiService {
  static const String _url = 'https://fakestoreapi.com/products';
  static const Duration _timeout = Duration(seconds: 10);

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_url)).timeout(_timeout);

      switch (response.statusCode) {
        case 200:
          final decoded = jsonDecode(response.body);
          if (decoded is! List) {
            throw const FormatException('Expected a JSON list');
          }
          return decoded
              .whereType<Map<String, dynamic>>()
              .map(Product.fromJson)
              .toList();
        case 404:
          throw const ApiException('Products were not found (404).',
              statusCode: 404);
        default:
          if (response.statusCode >= 500) {
            throw ApiException(
              'Server error (${response.statusCode}). Please try again later.',
              statusCode: response.statusCode,
            );
          }
          throw ApiException(
            'Unexpected response (${response.statusCode}).',
            statusCode: response.statusCode,
          );
      }
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(
          'The request timed out after 10 seconds. Check your connection.');
    } on http.ClientException {
      throw const ApiException(
          'No internet connection. Turn it on and try again.');
    } on FormatException {
      throw const ApiException('The server returned invalid data.');
    } catch (_) {
      throw const ApiException('Something went wrong. Please try again.');
    }
  }
}
