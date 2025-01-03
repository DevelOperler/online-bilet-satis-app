import 'package:flutter/material.dart';
import 'package:online_bilet_satis/providers/trip_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/seat_provider.dart';
import '../booking/payment_screen.dart';

class SeatSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final seatProvider = Provider.of<SeatProvider>(context);
    final tripProvider = Provider.of<TripProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Koltuk Seçimi')),
      body: Column(
        children: [
          Expanded(
            child: seatProvider.seats.isEmpty
                ? Center(
                    child: Text(
                      'Koltuk bilgisi bulunamadı. Lütfen tekrar deneyin.',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // 4 koltuk bir satırda
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: seatProvider.seats.length,
                    itemBuilder: (context, index) {
                      final seat = seatProvider.seats[index];
                      final isSelected =
                          seatProvider.selectedSeats.contains(seat);

                      return GestureDetector(
                        onTap: seat.status == 'available'
                            ? () {
                                seatProvider.toggleSeatSelection(seat);
                              }
                            : null,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: seat.status == 'booked'
                                ? Colors.red
                                : isSelected
                                    ? Colors.green
                                    : Colors.grey,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            seat.id,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // Onayla Butonu
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: seatProvider.selectedSeats.isNotEmpty
                  ? () {
                      final selectedTrip = tripProvider.selectedTrip;
                      if (selectedTrip != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              tripName: selectedTrip.name,
                              date: selectedTrip.date, // Tarih
                              time: selectedTrip.startTime, // Saat
                              seatNumbers: seatProvider.selectedSeats
                                  .map((seat) => seat.id)
                                  .toList(), // Koltuklar
                              price: selectedTrip.price, // Fiyat
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Sefer bilgisi bulunamadı!'),
                          ),
                        );
                      }
                    }
                  : null, // Eğer koltuk seçilmediyse buton devre dışı
              child: Text('Onayla'),
            ),
          ),
        ],
      ),
    );
  }
}
