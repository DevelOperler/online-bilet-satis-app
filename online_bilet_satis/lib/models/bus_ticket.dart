import 'package:hive/hive.dart';

part 'bus_ticket.g.dart';

@HiveType(typeId: 2)
class BusTicket extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String tripName;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String time;

  @HiveField(4)
  final String seatNumbers;

  @HiveField(5)
  final String price;

  BusTicket({
    required this.userId,
    required this.tripName,
    required this.date,
    required this.time,
    required this.seatNumbers,
    required this.price,
  });
}
