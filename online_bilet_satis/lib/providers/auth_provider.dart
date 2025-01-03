import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  String? _token;

  String? get token => _token;

  // Future<void> login(String email, String password) async {
  //   // Örnek API çağrısı (gerçek API URL'nizi kullanın)
  //   final response = await http.post(
  //     Uri.parse('https://example.com/api/login'),
  //     body: {
  //       'email': email,
  //       'password': password,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     _token = data['token'];

  //     // Token'ı güvenli depolamaya kaydet
  //     await _secureStorage.write(key: 'jwt_token', value: _token);

  //     notifyListeners();
  //   } else {
  //     throw Exception('Login failed');
  //   }
  // }

  // Future<void> register(String email, String password) async {
  //   final response = await http.post(
  //     Uri.parse('https://example.com/api/register'),
  //     body: {
  //       'email': email,
  //       'password': password,
  //     },
  //   );

  //   if (response.statusCode != 200) {
  //     throw Exception('Registration failed');
  //   }
  // }

  // Future<void> logout() async {
  //   // Token'ı sil
  //   await _secureStorage.delete(key: 'jwt_token');
  //   _token = null;

  //   notifyListeners();
  // }

  // Future<bool> checkLoginStatus() async {
  //   final storedToken = await _secureStorage.read(key: 'jwt_token');

  //   if (storedToken != null && !JwtDecoder.isExpired(storedToken)) {
  //     _token = storedToken;
  //     notifyListeners();
  //     return true;
  //   }

  //   return false;
  // }
}
