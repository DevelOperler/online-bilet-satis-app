import 'package:hive/hive.dart';

part 'bus_trip.g.dart';

@HiveType(typeId: 1)
class BusTrip extends HiveObject {
  // final String id; // Benzersiz sefer ID'si
  // final String name; // Firma adı
  // final String startLocation; // Nereden
  // final String endLocation; // Nereye
  // final String startTime; // Kalkış saati
  // final String arrivalTime; // Varış saati
  // final String date; // Sefer tarihi
  // final String price; // Fiyat bilgisi
  // final List<String> availableSeats; // Mevcut koltuklar

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String arrivalTime;

  @HiveField(2)
  final String startTime;

  @HiveField(3)
  final String price;

  @HiveField(4)
  final String name;

  @HiveField(5)
  final String startLocation;

  @HiveField(6)
  final String endLocation;

  @HiveField(7)
  final String date;

  @HiveField(8)
  final List<String> availableSeats;

  BusTrip({
    required this.id,
    required this.name,
    required this.startLocation,
    required this.endLocation,
    required this.startTime,
    required this.arrivalTime,
    required this.date,
    required this.price,
    this.availableSeats = const [], // Varsayılan olarak boş liste
  });

  // JSON'dan model oluşturmak için fabrika metodu
  factory BusTrip.fromJson(Map<String, dynamic> json) {
    return BusTrip(
      id: json['id'] ?? '0',
      name: json['name'] ?? '',
      startLocation: json['start'] ?? '',
      endLocation: json['end'] ?? '',
      startTime: json['starttime'] ?? '',
      arrivalTime: json['arrivetime'] ?? '',
      date: json['date'] ?? '', // Tarih alanını ekledik
      price: json['price'] ?? '0 TL',
      availableSeats: json['availableSeats'] != null
          ? List<String>.from(
              json['availableSeats']) // Mevcut koltukları listeye dönüştür
          : [],
    );
  }

  // Modelden JSON oluşturmak için metot
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start': startLocation,
      'end': endLocation,
      'starttime': startTime,
      'arrivetime': arrivalTime,
      'date': date, // Tarih alanını JSON'a ekledik
      'price': price,
      'availableSeats': availableSeats, // Koltuklar listesi
    };
  }
}
