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

  /// 🔹 Récupérer les réponses d'un message parent via `/api/messages/parent/{parentId}`
  Future<List<Message>> fetchReplies(int parentId) async {
  try {
    final headers = {
      'Accept': 'application/ld+json',
      'Content-Type': 'application/json',
    };

    final url = "$baseUrl/parent/$parentId"; // Utilisation correcte de la route
    final response = await http.get(Uri.parse(url), headers: headers);

    print("🔹 Réponses récupérées pour message ID $parentId : ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      // Si la réponse est un objet avec une clé "hydra:member"
      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey("hydra:member")) {
        List<dynamic> repliesJson = jsonResponse["hydra:member"];
        return repliesJson.map((item) => Message.fromJson(item)).toList();
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

      final headers = {
        'Accept': 'application/ld+json', // ✅ Correction du Content-Type
        'Content-Type': 'application/ld+json', // ✅ Correction du Content-Type
        'Authorization': 'Bearer $token',
      };

      // 🔹 URIs relatives demandées par l'API
      String userUri = "/forum/api/utilisateurs/$userId";
      String? parentUri =
          parentId != null ? "/forum_api/api/messages/$parentId" : null;

      // ✅ JSON conforme au cURL
      final body = jsonEncode({
        "titre": "Réponse",
        "datePoste": DateTime.now().toIso8601String(), // ✅ Ajout de la date
        "contenu": message,
        "user": userUri, // ✅ URI relative
        if (parentUri != null) "parent": parentUri, // ✅ URI relative
      });

      print("📤 Envoi de la requête : $body");

      final response =
          await http.post(Uri.parse(baseUrl), headers: headers, body: body);

      print(
          "🔹 Réponse API sendMessage : ${response.statusCode} - ${response.body}");

      if (response.statusCode != 201) {
        throw Exception(
            "❌ Erreur lors de l'envoi du message (${response.statusCode}) : ${response.body}");
      }

      print("✅ Message envoyé avec succès !");
    } catch (e) {
      print("❌ Exception sendMessage: $e");
      throw Exception("Erreur réseau : ${e.toString()}");
    }
  }
}
