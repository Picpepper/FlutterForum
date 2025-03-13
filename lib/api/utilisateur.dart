import 'package:http/http.dart' as http;
import 'dart:convert';

Future<int> inscrireUtilisateur(String pseudonyme, String email,
    String password, List<String> roles) async {
  var url = Uri.parse(
      'https://s3-4664.nuage-peda.fr/e52025/forum_api/public/api/utilisateurs');
  var headers = {'Content-Type': 'application/json'};
  var body = json.encode({
    'pseudonyme': pseudonyme,
    'email': email,
    'password': password,
    'roles': roles,
  });
  try {
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      print(
          "Échec de la requête : Code de statut ${response.statusCode}, Réponse : ${response.body}");
      return response.statusCode;
    }
  } catch (e) {
    print("Exception lors de la requête : $e");
    return 0;
  }
}

Future<http.Response> connecterUtilisateur(
    String email, String password) async {
  final url = Uri.parse(
      'https://s3-4664.nuage-peda.fr/e52025/forum_api/public/utilisateurs');
  final headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    'email': email,
    'password': password,
  });
  final response = await http.post(
    url,
    headers: headers,
    body: body,
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to login: ${response.reasonPhrase}');
  }
}
