import 'package:hive/hive.dart';

part 'seat.g.dart';

@HiveType(typeId: 3)
class Seat extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String status;

  @HiveField(2)
  final String tripId; // Koltuk hangi seferle ilişkili

  Seat({
    required this.id,
    required this.status,
    required this.tripId, // Yeni property
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      status: json['status'],
      tripId: json['tripId'], // Yeni property
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'tripId': tripId, // Yeni property
    };
  }
}
