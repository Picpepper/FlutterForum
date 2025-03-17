import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Configuration sécurisée pour Android et iOS
  static const _secureOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );

  static const _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // 🔑 Clés de stockage
  static const String _keyEmail = 'email';
  static const String _keyPassword = 'password';
  static const String _keyToken = 'token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserNom = 'user_nom';
  static const String _keyUserPrenom = 'user_prenom';

  /// 🔹 Sauvegarde des identifiants (email et password)
  Future<void> saveCredentials(String email, String password) async {
    try {
      await _storage.write(key: _keyEmail, value: email, iOptions: _secureOptions, aOptions: _androidOptions);
      await _storage.write(key: _keyPassword, value: password, iOptions: _secureOptions, aOptions: _androidOptions);
    } catch (e) {
      print("❌ Erreur lors de la sauvegarde des identifiants : $e");
    }
  }

  /// 🔹 Sauvegarde du token JWT
  Future<void> saveToken(String token) async {
    try {
      print("💾 Stockage du token : $token");
      await _storage.write(key: _keyToken, value: token, iOptions: _secureOptions, aOptions: _androidOptions);
    } catch (e) {
      print("❌ Erreur lors de la sauvegarde du token : $e");
    }
  }

  /// 🔹 Récupération des identifiants (email et password)
  Future<Map<String, String?>> readCredentials() async {
    try {
      return {
        'email': await _storage.read(key: _keyEmail, iOptions: _secureOptions, aOptions: _androidOptions),
        'password': await _storage.read(key: _keyPassword, iOptions: _secureOptions, aOptions: _androidOptions),
      };
    } catch (e) {
      print("❌ Erreur lors de la récupération des identifiants : $e");
      return {'email': null, 'password': null};
    }
  }

  /// 🔹 Récupération du token JWT
  Future<String?> readToken() async {
    try {
      String? token = await _storage.read(key: _keyToken, iOptions: _secureOptions, aOptions: _androidOptions);
      print("📡 Token récupéré : $token");
      return token;
    } catch (e) {
      print("❌ Erreur lors de la récupération du token : $e");
      return null;
    }
  }

  /// 🔹 Suppression des identifiants et du token
  Future<void> deleteCredentials() async {
    try {
      await _storage.delete(key: _keyEmail, iOptions: _secureOptions, aOptions: _androidOptions);
      await _storage.delete(key: _keyPassword, iOptions: _secureOptions, aOptions: _androidOptions);
      await _storage.delete(key: _keyToken, iOptions: _secureOptions, aOptions: _androidOptions);
    } catch (e) {
      print("❌ Erreur lors de la suppression des identifiants : $e");
    }
  }

  /// 🔹 Sauvegarde de l'ID utilisateur
  Future<void> saveUserId(String userId) async {
    try {
      await _storage.write(key: _keyUserId, value: userId, iOptions: _secureOptions, aOptions: _androidOptions);
    } catch (e) {
      print("❌ Erreur lors de la sauvegarde de l'ID utilisateur : $e");
    }
  }

  /// 🔹 Récupération de l'ID utilisateur
  Future<String?> readUserId() async {
    try {
      return await _storage.read(key: _keyUserId, iOptions: _secureOptions, aOptions: _androidOptions);
    } catch (e) {
      print("❌ Erreur lors de la récupération de l'ID utilisateur : $e");
      return null;
    }
  }

  /// 🔹 Suppression de l'ID utilisateur (déconnexion)
  Future<void> deleteUserId() async {
    try {
      await _storage.delete(key: _keyUserId, iOptions: _secureOptions, aOptions: _androidOptions);
    } catch (e) {
      print("❌ Erreur lors de la suppression de l'ID utilisateur : $e");
    }
  }

  /// 🔹 Sauvegarde du nom et prénom de l'utilisateur
  Future<void> saveUserInfo(String nom, String prenom) async {
    try {
      await _storage.write(key: _keyUserNom, value: nom, iOptions: _secureOptions, aOptions: _androidOptions);
      await _storage.write(key: _keyUserPrenom, value: prenom, iOptions: _secureOptions, aOptions: _androidOptions);
    } catch (e) {
      print("❌ Erreur lors de la sauvegarde des informations utilisateur : $e");
    }
  }

  /// 🔹 Récupération du nom et prénom
  Future<Map<String, String?>> readUserInfo() async {
    try {
      return {
        'nom': await _storage.read(key: _keyUserNom, iOptions: _secureOptions, aOptions: _androidOptions),
        'prenom': await _storage.read(key: _keyUserPrenom, iOptions: _secureOptions, aOptions: _androidOptions),
      };
    } catch (e) {
      print("❌ Erreur lors de la récupération des informations utilisateur : $e");
      return {'nom': null, 'prenom': null};
    }
  }

  /// 🔹 Suppression des informations de l'utilisateur
  Future<void> deleteUserInfo() async {
    try {
      await _storage.delete(key: _keyUserNom, iOptions: _secureOptions, aOptions: _androidOptions);
      await _storage.delete(key: _keyUserPrenom, iOptions: _secureOptions, aOptions: _androidOptions);
    } catch (e) {
      print("❌ Erreur lors de la suppression des informations utilisateur : $e");
    }
  }

  /// 🔹 Suppression de toutes les données utilisateur
  Future<void> deleteAllUserData() async {
    try {
      await deleteCredentials();
      await deleteUserId();
      await deleteUserInfo();
    } catch (e) {
      print("❌ Erreur lors de la suppression de toutes les données utilisateur : $e");
    }
  }
}
