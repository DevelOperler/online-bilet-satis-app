import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ticket_provider.dart';

class TicketHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);
    final userTickets =
        ticketProvider.getUserTickets(); // Kullanıcıya ait ticket'lar

    return Scaffold(
      appBar: AppBar(
        title: Text('Geçmiş Biletler'),
      ),
      body: userTickets.isEmpty
          ? Center(
              child: Text(
                'Henüz geçmiş biletiniz yok.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: userTickets.length,
              itemBuilder: (context, index) {
                final ticket = userTickets[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: ListTile(
                    title: Text(
                      ticket.tripName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Tarih: ${ticket.date}\nSaat: ${ticket.time}\nKoltuk: ${ticket.seatNumbers}\nFiyat: ${ticket.price}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
