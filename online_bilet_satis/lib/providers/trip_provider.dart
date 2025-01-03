import 'package:flutter/material.dart';
import '../models/bus_trip.dart';

class TripProvider with ChangeNotifier {
  // FilterService _filterService = FilterService();
  List<BusTrip> _trips = [];
  List<BusTrip> _filteredTrips = [];
  BusTrip? _selectedTrip;

  // Getter for all trips
  List<BusTrip> get trips => _trips;

  // Getter for filtered trips
  List<BusTrip> get filteredTrips => _filteredTrips;

  // Getter for selected trip
  BusTrip? get selectedTrip => _selectedTrip;

  Future<void> setTrips(List<BusTrip> trips) async {
    _trips = trips;
    _filteredTrips = trips;
    notifyListeners();
  }

  // Fetch all trips from the service
  Future<void> fetchTrips() async {
    try {
      // var trips = await _filterService.getAllTrips();
      _trips = trips;
      _filteredTrips = trips; // Initially, all trips are filtered
      notifyListeners();
    } catch (error) {
      print('Seferler alınırken hata oluştu: $error');
    }
  }

  // Filter trips based on start and end location
  Future<void> filterTrips(
      {String startLocation = "", String endLocation = ""}) async {
    try {
      // final filteredTrips = await _filterService.getTripsByLocation(
      // startLocation,
      // endLocation,
      // );
      _filteredTrips = filteredTrips;
      if (_filteredTrips.isEmpty) {
        print("Bu kriterlere uygun sefer bulunamadı.");
      }
      notifyListeners();
    } catch (error) {
      print('Filtreleme sırasında hata oluştu: $error');
    }
  }

  // Select a trip
  void selectTrip(BusTrip trip) {
    _selectedTrip = trip;
    notifyListeners();
  }

  // Add a new trip
  void addTrip(BusTrip trip) {
    _trips.add(trip);
    notifyListeners();
  }

  // Find a trip by ID
  BusTrip? findTripById(String id) {
    return _trips.firstWhere((trip) => trip.id == id);
  }
}
