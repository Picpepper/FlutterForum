import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modele/message.dart';
import '../utils/secure_storage.dart';

class ApiService {
  static const String baseUrl =
      "https://s3-4686.nuage-peda.fr/forum/api/messages";
  final SecureStorage secureStorage = SecureStorage();

  /// récupérer tous les messages
  Future<List<Message>> fetchMessages() async {
    try {
      final headers = {
        'Accept': 'application/ld+json',
        'Content-Type': 'application/json',
      };

      final response = await http.get(Uri.parse(baseUrl), headers: headers);

      print("🔹 Status Code: ${response.statusCode}");
      print("🔹 Réponse brute: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse.containsKey("hydra:member")) {
          List<dynamic> messagesJson = jsonResponse["hydra:member"];
          List<Message> messages =
              messagesJson.map((item) => Message.fromJson(item)).toList();

          print("✅ ${messages.length} messages récupérés !");
          return messages;
        } else {
          throw Exception("❌ Format inattendu : ${response.body}");
        }
      } else {
        throw Exception("⚠️ Erreur API (${response.statusCode})");
      }
    } catch (e) {
      print("❌ Exception: $e");
      throw Exception("Erreur réseau : ${e.toString()}");
    }
  }

  Future<List<Message>> fetchReplies(int parentId) async {
  try {
    final headers = {
      'Accept': 'application/ld+json',
      'Content-Type': 'application/json',
    };
    final url = "$baseUrl/$parentId"; // Endpoint pour récupérer le message parent et ses réponses
    final response = await http.get(Uri.parse(url), headers: headers);

    print("🔹 Réponses récupérées pour message ID $parentId : ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      // Vérifie si la réponse est un objet JSON et contient le champ "messages"
      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey("messages")) {
        List<dynamic> repliesJson = jsonResponse["messages"];
        List<Message> replies = repliesJson.map((item) => Message.fromJson(item)).toList();
        return replies;
      } else {
        throw Exception("❌ Format inattendu dans la réponse : ${response.body}");
      }
    } else {
      throw Exception("⚠️ Erreur API fetchReplies (${response.statusCode})");
    }
  } catch (e) {
    print("❌ Exception fetchReplies: $e");
    throw Exception("Erreur réseau : ${e.toString()}");
  }
}

  Future<void> sendMessage(String message, {int? parentId}) async {
  try {
    String? token = await secureStorage.readToken();
    if (token == null) throw Exception("Utilisateur non authentifié.");

    String? userId = await secureStorage.readUserId();
    if (userId == null) throw Exception("Utilisateur non connecté !");

    if (message.isEmpty) throw Exception("Le message ne peut pas être vide.");

    final headers = {
      'Accept': 'application/ld+json',
      'Content-Type': 'application/ld+json',
      'Authorization': 'Bearer $token',
    };

    String userUri = "/forum/api/utilisateurs/$userId";
    String? parentUri = parentId != null ? "/forum/api/messages/$parentId" : null;

    final body = jsonEncode({
      "titre": "Réponse",
      "datePoste": DateTime.now().toIso8601String(),
      "contenu": message,
      "user": userUri,
      if (parentUri != null) "parent": parentUri,
    });

    print("📤 Envoi de la requête :");
    print("URL : $baseUrl");
    print("Headers : $headers");
    print("Body : $body");

    final response = await http.post(Uri.parse(baseUrl), headers: headers, body: body);

    print("🔹 Réponse API sendMessage :");
    print("Statut : ${response.statusCode}");
    print("Body : ${response.body}");

    if (response.statusCode != 201) {
      throw Exception("❌ Erreur lors de l'envoi du message (${response.statusCode}) : ${response.body}");
    }

    print("✅ Message envoyé avec succès !");
  } catch (e, stackTrace) {
    print("❌ Exception sendMessage: $e");
    print("Stack Trace: $stackTrace");
    throw Exception("Erreur réseau : ${e.toString()}");
  }
}
}
