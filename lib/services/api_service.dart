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
    final uri = Uri.parse(
      _join(baseUrl, path),
    ).replace(queryParameters: query?.map((k, v) => MapEntry(k, '$v')));
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
    final res = await _postJson(
      path,
      body: {'username': username, 'password': password},
    );
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

  Future<Map<String, dynamic>> createPersonnel(
    Map<String, dynamic> body,
  ) async {
    return _postJson('/personnels', body: body);
  }

  Future<Map<String, dynamic>> createEleve(Map<String, dynamic> body) async {
    return _postJson('/eleves', body: body);
  }

  Future<Map<String, dynamic>> assignRole(Map<String, dynamic> body) async {
    return _postJson('/personne_role', body: body);
  }

  Future<Map<String, dynamic>> createDroitAcces(
    Map<String, dynamic> body,
  ) async {
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
      message:
          jsonMap['error']?.toString() ??
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

  /// Composite helper: submit a typical student registration flow.
  /// Creates a `personne` with type_personne 'eleve', then an `eleve` row,
  /// and optionally a `droit_acces` entry.
  Future<Map<String, dynamic>> submitRegistrationStudent({
    required String prenom,
    required String nom,
    required String email,
    required String telephone,
    required String organisation,
    required String motifDemande,
    required String classe,
    String? numeroEtudiant,
    int? idPorte,
    String? raisonAcces,
    DateTime? dateDebut,
    DateTime? dateFin,
    int? creePar,
  }) async {
    // Step 1: create person (eleve)
    final personRes = await createPerson({
      'prenom': prenom,
      'nom': nom,
      'email': email,
      'organisation': organisation,
      'motif_demande': motifDemande,
      'telephone': telephone,
      'type_personne': 'eleve',
      'actif': 1,
    });

    final idPersonne = personRes['id'] ?? personRes['id_personne'];
    if (idPersonne == null) {
      throw ApiException(
        statusCode: 500,
        message: 'Missing id_personne from /personnes',
      );
    }

    // Step 2: create eleve row
    final eleveRes = await createEleve({
      'id_personne': idPersonne,
      'classe': classe,
      if (numeroEtudiant != null) 'numero_etudiant': numeroEtudiant,
    });

    Map<String, dynamic>? droitRes;
    if (idPorte != null) {
      droitRes = await createDroitAcces({
        'id_personne': idPersonne,
        'id_porte': idPorte,
        if (dateDebut != null) 'date_debut': dateDebut.toIso8601String(),
        if (dateFin != null) 'date_fin': dateFin.toIso8601String(),
        if (creePar != null) 'cree_par': creePar,
        if (raisonAcces != null) 'raison': raisonAcces,
      });
    }

    return {
      'id_personne': idPersonne,
      'personne': personRes,
      'eleve': eleveRes,
      if (droitRes != null) 'droit_acces': droitRes,
    };
  }

  void close() {
    _client.close();
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;
  final String? rawBody;

  ApiException({required this.statusCode, required this.message, this.rawBody});

  @override
  String toString() => 'ApiException($statusCode): $message';
}
