import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/trip_provider.dart';
import '../../providers/seat_provider.dart';
import '../../services/notification_service.dart';
import '../booking/seat_selection_screen.dart';

class TripDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedTrip = Provider.of<TripProvider>(context).selectedTrip;

    if (selectedTrip == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Detay')),
        body: Center(
          child: Text('Sefer bilgisi eksik. Lütfen tekrar deneyin.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Sefer Detayları')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sefer Detayları',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Firma: ${selectedTrip.name}'),
            Text('Kalkış: ${selectedTrip.startLocation}'),
            Text('Varış: ${selectedTrip.endLocation}'),
            Text(
                'Saat: ${selectedTrip.startTime} - ${selectedTrip.arrivalTime}'),
            Text('Fiyat: ${selectedTrip.price}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final notificationService = NotificationService();
                final DateTime biletSaati =
                    DateTime.now().add(Duration(minutes: 5)); // 5 dakika sonra

                notificationService.scheduleNotification(
                  id: 1,
                  title: 'Biletiniz Yaklaşıyor!',
                  body: 'Sefer saatine 5 dakika kaldı. Lütfen hazırlanın.',
                  scheduledTime: biletSaati,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Bildirim planlandı!')),
                );
              },
              child: Text('Bildirim Planla'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Provider.of<SeatProvider>(context, listen: false)
                    .loadTestSeats();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SeatSelectionScreen()),
                );
              },
              child: Text('Koltuk Seçimi'),
            ),
          ],
        ),
      ),
    );
  }
}
