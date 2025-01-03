import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/seat_provider.dart';
import '../../providers/trip_provider.dart';

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedTrip = Provider.of<TripProvider>(context).selectedTrip;
    final selectedSeats = Provider.of<SeatProvider>(context).selectedSeats;

    if (selectedTrip == null || selectedSeats.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Rezervasyon')),
        body: Center(
          child: Text('Sefer veya koltuk bilgisi eksik.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Rezervasyon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sefer Detayları', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Firma: ${selectedTrip.name}'),
            Text('Kalkış: ${selectedTrip.startLocation}'),
            Text('Varış: ${selectedTrip.endLocation}'),
            Text(
                'Saat: ${selectedTrip.startTime} - ${selectedTrip.arrivalTime}'),
            Text('Fiyat: ${selectedTrip.price}'),
            SizedBox(height: 16),
            Text(
              'Seçilen Koltuklar: ${selectedSeats.map((s) => s.id).join(', ')}',
            ),
          ],
        ),
      ),
    );
  }
}
