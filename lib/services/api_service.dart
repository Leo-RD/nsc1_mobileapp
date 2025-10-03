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
    String? _jwtToken;
    ApiService({
      required this.baseUrl,
      required this.basicAuthUser,
      required this.basicAuthPass,
      http.Client? client,
    }) : _client = client ?? http.Client();

  Map<String, String> _headers({Map<String, String>? extra}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (_jwtToken != null && _jwtToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_jwtToken';
    } else {
      final auth = base64Encode(utf8.encode('$basicAuthUser:$basicAuthPass'));
      headers['Authorization'] = 'Basic $auth';
    }
    if (extra != null) headers.addAll(extra);
    return headers;
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

  /// Default instance using the credentials you provided.
  /// Replace [baseUrl] with your API host before using.
  static ApiService defaultInstance({
    String baseUrl = 'https://kasalali.alwaysdata.net/API_NSC1',
  }) {
    return ApiService(
      baseUrl: baseUrl,
      basicAuthUser: 'NSC1_API',
      basicAuthPass: 'Jone_Porte!87-/',
    );
  }

  /// Login endpoint (per routesJWT.php). Body fields: username, password.
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    const path = '/login';
    final res = await _postJson(path, body: {
      'username': username,
      'password': password,
    });
    // Capture JWT token if present
    final token = res['token']?.toString();
    if (token != null && token.isNotEmpty) {
      _jwtToken = token;
    }
    return res;
  }

  // ==== Domain helpers aligned to exposed routes (see routes.php) ====

  Future<Map<String, dynamic>> createPerson(Map<String, dynamic> body) async {
    // POST /personnes -> { id: <new_id> }
    return _postJson('/personnes', body: body);
  }

  Future<Map<String, dynamic>> createPersonnel(Map<String, dynamic> body) async {
    return _postJson('/personnels', body: body);
  }

  Future<Map<String, dynamic>> createEleve(Map<String, dynamic> body) async {
    return _postJson('/eleves', body: body);
  }

  Future<Map<String, dynamic>> assignRole(Map<String, dynamic> body) async {
    return _postJson('/personne_role', body: body);
  }

  Future<Map<String, dynamic>> createDroitAcces(Map<String, dynamic> body) async {
    return _postJson('/droit_acces', body: body);
  }

  Future<Map<String, dynamic>> addAccesLog(Map<String, dynamic> body) async {
    return _postJson('/acces_log', body: body);
  }

  Future<Map<String, dynamic>> getAccesLog({int last = 100}) async {
    return _getJson('/acces_log');
  }

  Map<String, dynamic> _decodeResponse(http.Response resp) {
    final code = resp.statusCode;
    final text = resp.body;
    Map<String, dynamic> jsonMap;
    try {
      jsonMap = text.isEmpty
          ? <String, dynamic>{}
          : (jsonDecode(text) as Map<String, dynamic>);
    } catch (_) {
      throw ApiException(
        statusCode: code,
        message: 'Invalid JSON from server',
        rawBody: text,
      );
    }

    if (code >= 200 && code < 300) {
      return jsonMap;
    }

    throw ApiException(
      statusCode: code,
      message: jsonMap['error']?.toString() ??
          jsonMap['message']?.toString() ??
          'Request failed ($code)',
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

