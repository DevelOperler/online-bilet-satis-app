import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  late Dio _dio;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  DioClient() {
    _dio = Dio(
      BaseOptions(
        // baseUrl: 'http://10.0.2.2:8080/api/', // API'nin temel URL'si
        baseUrl: 'http://backend:8080/api/', // API'nin temel URL'si
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // Token interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'jwt_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Dio get dio => _dio;
}
