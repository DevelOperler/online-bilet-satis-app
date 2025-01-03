import 'package:dio/dio.dart';
import '../models/bus_trip.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl =
        'https://api.collectapi.com/travel'; // Backend API endpoint'inizi buraya yazın
    _dio.options.headers['authorization'] =
        'apikey 6MeRpJrNvnzHuFWC9uEmIq:00msqahh7CC6gpWnruLOyj';
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.connectTimeout = Duration(milliseconds: 5000); // 5 saniye
    _dio.options.receiveTimeout = Duration(milliseconds: 3000); // 3 saniye
  }

  Future<List<BusTrip>> fetchBusTrips() async {
    try {
      // Sadece hata giderene kadar aşağıdaki kodu kullan
      await Future.delayed(Duration(seconds: 2)); // Simüle edilmiş gecikme
      return [
        BusTrip(
          id: '1',
          name: 'Özkaymak',
          startLocation: 'İstanbul Otogar',
          endLocation: 'Ankara AŞTİ',
          startTime: '09:00',
          arrivalTime: '14:00',
          date: '2024-01-01',
          price: '200 TL',
          availableSeats: ['1A', '1B', '2A', '2B'],
        ),
        BusTrip(
          id: '2',
          name: 'Metro Turizm',
          startLocation: 'İzmir Otogar',
          endLocation: 'İstanbul Otogar',
          startTime: '07:30',
          arrivalTime: '13:00',
          date: '2024-01-02',
          price: '250 TL',
          availableSeats: ['3A', '3B', '4A'],
        ),
      ];
    } catch (e) {
      print('Hata: $e');
      throw Exception('Sefer verileri yüklenemedi');
    }
  }
}
