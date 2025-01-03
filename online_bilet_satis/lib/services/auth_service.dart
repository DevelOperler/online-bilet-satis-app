import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:online_bilet_satis/services/dio_client.dart';

class AuthService {
  final DioClient dioClient;
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String mockEmail = 'mockuser@example.com';
  static const String mockPassword = 'Test123456';
  static const String mockJwtToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMjM0NTY3ODkwLCJpYXQiOjE2MjcwNjUyMDB9.PY4HsjXWxz_VmE_f3Xx5Atn17Jg2y__EoV91DDlvW5o';

  AuthService(this.dioClient);

  Future<String> login(String email, String password) async {
    try {
      final response = await dioClient.dio.post(
        'login',
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];

        // Token'ı güvenli depolamaya kaydet
        await _storage.write(key: 'jwt_token', value: token);
        return token;
      } else {
        if (email == mockEmail && password == mockPassword) {
          // Mock token'ı depola
          await _storage.write(key: 'jwt_token', value: mockJwtToken);
          return mockJwtToken;
        } else {
          throw Exception('Login failed: Invalid email or password');
        }
      }
    } on DioError catch (e) {
      throw Exception(
          'Login failed: ${e.response?.data['message'] ?? e.message}');
    }
  }

  Future<void> register(String email, String password) async {
    // if (email.isNotEmpty && password.isNotEmpty) {
    //   return; // Başarılı kabul edelim
    // } else {
    //   throw Exception('Registration failed: Invalid inputs');
    // }

    try {
      await dioClient.dio.post(
        'register',
        data: {
          "email": email,
          "password": password,
        },
      );
    } on DioError catch (e) {
      throw Exception(
          'Registration failed: ${e.response?.data['message'] ?? e.message}');
    }
  }

  Future<void> logout() async {
    // Token'ı güvenli depolamadan sil
    await _storage.delete(key: 'jwt_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'jwt_token');
    return token != null;
  }
}
