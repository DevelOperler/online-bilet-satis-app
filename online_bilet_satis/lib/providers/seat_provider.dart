import 'package:flutter/material.dart';
import '../models/seat.dart';

class SeatProvider with ChangeNotifier {
  List<Seat> _seats = [];
  List<Seat> _selectedSeats = [];

  List<Seat> get seats => _seats;
  List<Seat> get selectedSeats => _selectedSeats;

  void setSeats(List<Seat> seats) {
    _seats = seats;
    notifyListeners();
  }

  void toggleSeatSelection(Seat seat) {
    if (_selectedSeats.contains(seat)) {
      _selectedSeats.remove(seat);
    } else {
      _selectedSeats.add(seat);
    }
    notifyListeners();
  }

  // Test verilerini yükleyen bir metot
  void loadTestSeats() {
    _seats = [
      Seat(tripId: "1", id: '1A', status: 'available'),
      Seat(tripId: "1", id: '1B', status: 'booked'),
      Seat(tripId: "1", id: '1C', status: 'available'),
      Seat(tripId: "1", id: '1D', status: 'available'),
      Seat(tripId: "1", id: '2A', status: 'available'),
      Seat(tripId: "1", id: '2B', status: 'booked'),
      Seat(tripId: "1", id: '2C', status: 'available'),
      Seat(tripId: "1", id: '2D', status: 'available'),
    ];
    notifyListeners();
  }
}
