import 'package:dio/dio.dart';

class ChatbotService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.openai.com/v1/', // OpenAI veya diğer API'nin URL'si
      headers: {
        'Authorization':
            'Bearer YOUR_API_KEY', // API anahtarınızı buraya ekleyin
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<String> sendMessage(String message) async {
    try {
      final response = await _dio.post(
        'chat/completions', // OpenAI ChatGPT endpoint'i
        data: {
          "model": "gpt-3.5-turbo", // Kullanılan model
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": message},
          ],
        },
      );

      final String reply = response.data['choices'][0]['message']['content'];
      return reply;
    } catch (e) {
      return 'Bir hata oluştu: ${e.toString()}';
    }
  }
}
