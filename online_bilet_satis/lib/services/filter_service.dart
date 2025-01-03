import 'package:hive/hive.dart';
import '../models/bus_trip.dart';

class FilterService {
  final String boxName = 'bus_trip';

  // Hive'daki tüm seferleri getir
  Future<List<BusTrip>> getAllTrips() async {
    final box = await Hive.openBox<BusTrip>(boxName);
    final trips = box.values.toList();

    await box.close();
    return trips;
  }

  // from ve to parametrelerine göre filtreleme yap
  Future<List<BusTrip>> getTripsByLocation(String from, String to) async {
    final box = await Hive.openBox<BusTrip>(boxName);

    if (Hive.isBoxOpen(boxName)) {
      print("Box is open");
      final allTrips = box.values.toList();

      await box.close();
      final trips = allTrips
          .where((trip) =>
              trip.startLocation.toLowerCase() == from.toLowerCase() &&
              trip.endLocation.toLowerCase() == to.toLowerCase())
          .toList();

      return trips.toList();
    } else {
      print("Box is not open");
    }
    return [];
  }

  // date ile filtreleme yap
  Future<List<BusTrip>> getTripsByDate(String date) async {
    final box = await Hive.openBox<BusTrip>(boxName);
    final trips = box.values.where((trip) => trip.date == date).toList();
    await box.close();
    return trips;
  }
}
