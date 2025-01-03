import 'package:flutter/material.dart';
import 'package:online_bilet_satis/views/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import '../booking/ticket_history_screen.dart';
import '../../providers/ticket_provider.dart';
import '../../models/bus_ticket.dart';

class PaymentScreen extends StatelessWidget {
  final String tripName;
  final String date;
  final String time;
  final List<String> seatNumbers;
  final String price;

  PaymentScreen({
    required this.tripName,
    required this.date,
    required this.time,
    required this.seatNumbers,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ödeme Ekranı')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final ticketProvider =
                Provider.of<TicketProvider>(context, listen: false);

            // Ödeme tamamlandıktan sonra WorkManager görevi planlanır
            final Duration delay = Duration(seconds: 10); // Test için 10 saniye
            if (delay.inSeconds > 0) {
              Workmanager().registerOneOffTask(
                "unique_task_id", // Görev için benzersiz ID
                "send_notification", // İşlem adı
                initialDelay: delay, // Gecikme süresi
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Bildirim planlandı!')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Sefer saati çok yakın, bildirim planlanamadı.'),
                ),
              );
            }

            final newTicket = BusTicket(
              userId: ticketProvider.currentUserId, // Kullanıcı ID'si
              tripName: tripName,
              date: date,
              time: time,
              seatNumbers: seatNumbers.join(", "),
              price: price.toString(),
            );
            ticketProvider.addTicket(newTicket);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Bilet başarıyla eklendi!')),
            );

            // Geçmiş biletler ekranına yönlendir
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
          child: Text('Ödemeyi Tamamla'),
        ),
      ),
    );
  }
}
