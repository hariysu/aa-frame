import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';

/// Exception thrown when API requests fail
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() =>
      'ApiException: $message ${statusCode != null ? '(Status code: $statusCode)' : ''}';
}

/// Service for handling API requests
class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Make a GET request
  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response = await _client.get(
        Uri.parse('${AppConstants.baseUrl}/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
      ).timeout(Duration(milliseconds: AppConstants.connectionTimeout));

      return _handleResponse(response);
    } catch (e) {
      throw ApiException('Failed to make GET request: $e');
    }
  }

  /// Make a POST request
  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final response = await _client
          .post(
            Uri.parse('${AppConstants.baseUrl}/$endpoint'),
            headers: {
              'Content-Type': 'application/json',
              ...?headers,
            },
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(Duration(milliseconds: AppConstants.connectionTimeout));

      return _handleResponse(response);
    } catch (e) {
      throw ApiException('Failed to make POST request: $e');
    }
  }

  /// Make a PUT request
  Future<Map<String, dynamic>> put(String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final response = await _client
          .put(
            Uri.parse('${AppConstants.baseUrl}/$endpoint'),
            headers: {
              'Content-Type': 'application/json',
              ...?headers,
            },
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(Duration(milliseconds: AppConstants.connectionTimeout));

      return _handleResponse(response);
    } catch (e) {
      throw ApiException('Failed to make PUT request: $e');
    }
  }

  /// Make a DELETE request
  Future<Map<String, dynamic>> delete(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response = await _client.delete(
        Uri.parse('${AppConstants.baseUrl}/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
      ).timeout(Duration(milliseconds: AppConstants.connectionTimeout));

      return _handleResponse(response);
    } catch (e) {
      throw ApiException('Failed to make DELETE request: $e');
    }
  }

  /// Handle API response
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }

      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw ApiException('Failed to parse response: $e');
      }
    } else {
      throw ApiException(
        'Request failed with status: ${response.statusCode}',
        statusCode: response.statusCode,
      );
    }
  }

  /// Close the client when done
  void dispose() {
    _client.close();
  }
}
