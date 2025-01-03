import 'package:dio/dio.dart';

class PaymentService {
  final Dio _dio = Dio();

  Future<bool> makePayment(String tripId, List<String> seatIds) async {
    try {
      final response = await _dio.post(
        'https://api.example.com/payment',
        data: {
          'tripId': tripId,
          'seatIds': seatIds,
        },
      );

      if (response.statusCode == 200) {
        return true; // Ödeme başarılı
      } else {
        return false; // Ödeme başarısız
      }
    } catch (e) {
      print('Hata: $e');
      return false;
    }
  }
}
