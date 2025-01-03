import 'package:flutter/material.dart';
import 'package:online_bilet_satis/services/auth_service.dart';
import 'package:online_bilet_satis/services/dio_client.dart';
import 'package:online_bilet_satis/views/booking/ticket_history_screen.dart';
import 'package:online_bilet_satis/views/home/chat_screen.dart';

class UserScreen extends StatelessWidget {
  // Dummy kullanıcı bilgileri
  final Map<String, String> userInfo = {
    "name": "Ahmet Yılmaz",
    "email": "ahmet.yilmaz@example.com",
    "phone": "+90 555 123 4567"
  };

  // Dummy geçmiş seyahatler
  final List<Map<String, String>> travelHistory = [
    {"date": "2023-12-01", "destination": "İstanbul"},
    {"date": "2023-11-15", "destination": "Ankara"},
    {"date": "2023-10-05", "destination": "İzmir"},
  ];

  final authService = AuthService(DioClient());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Ekranı"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kullanıcı bilgileri
            Text(
              "Kullanıcı Bilgileri",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Ad: ${userInfo['name']}"),
            Text("E-posta: ${userInfo['email']}"),
            Text("Telefon: ${userInfo['phone']}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authService.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Çıkış Yap'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              child: Text('Chatbot'),
            ),
            // Geçmiş Seyahatler
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketHistoryScreen(),
                  ),
                );
              },
              child: Text('Geçmiş Seyahatlerim'),
            ),
          ],
        ),
      ),
    );
  }
}
