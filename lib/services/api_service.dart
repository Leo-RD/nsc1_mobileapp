import 'dart:convert';
import 'package:http/http.dart' as http;

/// API client for NSC1 app using Basic Auth.
///
/// IMPORTANT:
/// - Set the correct baseUrl to your Slim API host.
/// - Update endpoint paths/fields to match your routes.
class ApiService {
  final String baseUrl;
  final String basicAuthUser;
  final String basicAuthPass;
  final http.Client _client;

  ApiService({
    required this.baseUrl,
    required this.basicAuthUser,
    required this.basicAuthPass,
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// Default instance using the credentials you provided.
  /// Replace [baseUrl] with your API host before using.
  static ApiService defaultInstance({
    String baseUrl = 'http://127.0.0.1:8080', // TODO: change to your API base URL
  }) {
    return ApiService(
      baseUrl: baseUrl,
      basicAuthUser: 'NSC1_API',
      basicAuthPass: 'Jone_Porte!87-/',
    );
  }

  Map<String, String> _headers({Map<String, String>? extra}) {
    final auth = base64Encode(utf8.encode('$basicAuthUser:$basicAuthPass'));
    return {
      'Authorization': 'Basic $auth',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (extra != null) ...extra,
    };
  }

  Future<Map<String, dynamic>> _postJson(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(_join(baseUrl, path));
    final resp = await _client.post(
      uri,
      headers: _headers(extra: headers),
      body: body == null ? null : jsonEncode(body),
    );
    return _decodeResponse(resp);
  }

  Future<Map<String, dynamic>> _getJson(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final uri = Uri.parse(_join(baseUrl, path)).replace(
      queryParameters: query?.map((k, v) => MapEntry(k, '$v')),
    );
    final resp = await _client.get(uri, headers: _headers(extra: headers));
    return _decodeResponse(resp);
  }

  /// Login endpoint (example). Adjust path/field names to match your API.
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    const path = '/auth/login'; // TODO: confirm
    return _postJson(path, body: {
      'username': username,
      'password': password,
    });
  }

  /// Registration request endpoint (example). Adjust path/fields.
  Future<Map<String, dynamic>> submitRegistration({
    required String fullName,
    required String email,
    required String phone,
    required String company,
  }) async {
    const path = '/registration/requests'; // TODO: confirm
    return _postJson(path, body: {
      'name': fullName,
      'email': email,
      'phone': phone,
      'company': company,
    });
  }

  Map<String, dynamic> _decodeResponse(http.Response resp) {
    final code = resp.statusCode;
    final text = resp.body;

    Map<String, dynamic> json;
    try {
      json = text.isEmpty ? <String, dynamic>{} : (jsonDecode(text) as Map<String, dynamic>);
    } catch (_) {
      throw ApiException(
        statusCode: code,
        message: 'Invalid JSON from server',
        rawBody: text,
      );
    }

    if (code >= 200 && code < 300) {
      return json;
    }

    throw ApiException(
      statusCode: code,
      message: json['message']?.toString() ?? 'Request failed ($code)',
      rawBody: text,
    );
  }

  String _join(String base, String path) {
    if (base.endsWith('/')) base = base.substring(0, base.length - 1);
    if (!path.startsWith('/')) path = '/$path';
    return '$base$path';
  }

  void close() {
    _client.close();
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;
  final String? rawBody;

  ApiException({
    required this.statusCode,
    required this.message,
    this.rawBody,
  });

  @override
  String toString() => 'ApiException($statusCode): $message';
}

