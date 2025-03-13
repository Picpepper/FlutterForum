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
  static const String _keyUserPseudonyme = 'user_pseudonyme';

  /// 🔹 Sauvegarde des identifiants (email et password)
  Future<void> saveCredentials(String email, String password) async {
    await _storage.write(
        key: _keyEmail,
        value: email,
        iOptions: _secureOptions,
        aOptions: _androidOptions);
    await _storage.write(
        key: _keyPassword,
        value: password,
        iOptions: _secureOptions,
        aOptions: _androidOptions);
  }

  /// 🔹 Sauvegarde du token JWT
  Future<void> saveToken(String token) async {
    print("💾 Stockage du token : $token");
    await _storage.write(
        key: _keyToken,
        value: token,
        iOptions: _secureOptions,
        aOptions: _androidOptions);
  }

  /// 🔹 Récupération des identifiants (email et password)
  Future<Map<String, String?>> readCredentials() async {
    return {
      'email': await _storage.read(
          key: _keyEmail, iOptions: _secureOptions, aOptions: _androidOptions),
      'password': await _storage.read(
          key: _keyPassword,
          iOptions: _secureOptions,
          aOptions: _androidOptions),
    };
  }

  /// 🔹 Récupération du token JWT
  Future<String?> readToken() async {
    String? token = await _storage.read(
        key: _keyToken, iOptions: _secureOptions, aOptions: _androidOptions);
    print("📡 Token récupéré : $token");
    return token;
  }

  /// 🔹 Suppression des identifiants et du token
  Future<void> deleteCredentials() async {
    await _storage.delete(
        key: _keyEmail, iOptions: _secureOptions, aOptions: _androidOptions);
    await _storage.delete(
        key: _keyPassword, iOptions: _secureOptions, aOptions: _androidOptions);
    await _storage.delete(
        key: _keyToken, iOptions: _secureOptions, aOptions: _androidOptions);
  }

  /// 🔹 Sauvegarde de l'ID utilisateur
  Future<void> saveUserId(String userId) async {
    await _storage.write(
        key: _keyUserId,
        value: userId,
        iOptions: _secureOptions,
        aOptions: _androidOptions);
  }

  /// 🔹 Récupération de l'ID utilisateur
  Future<String?> readUserId() async {
    return await _storage.read(
        key: _keyUserId, iOptions: _secureOptions, aOptions: _androidOptions);
  }

  /// 🔹 Suppression de l'ID utilisateur (déconnexion)
  Future<void> deleteUserId() async {
    await _storage.delete(
        key: _keyUserId, iOptions: _secureOptions, aOptions: _androidOptions);
  }

  /// 🔹 Sauvegarde du pseudonyme de l'utilisateur
  Future<void> saveUserInfo(String pseudonyme) async {
    await _storage.write(
        key: _keyUserPseudonyme,
        value: pseudonyme,
        iOptions: _secureOptions,
        aOptions: _androidOptions);
  }

  /// 🔹 Récupération du pseudonyme
  Future<Map<String, String?>> readUserInfo() async {
    return {
      'pseudonyme': await _storage.read(
          key: _keyUserPseudonyme,
          iOptions: _secureOptions,
          aOptions: _androidOptions),
    };
  }

  /// 🔹 Suppression des informations de l'utilisateur
  Future<void> deleteUserInfo() async {
    await _storage.delete(
        key: _keyUserPseudonyme,
        iOptions: _secureOptions,
        aOptions: _androidOptions);
  }
}
