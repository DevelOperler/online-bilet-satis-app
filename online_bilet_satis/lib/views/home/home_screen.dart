import 'package:flutter/material.dart';
import 'package:online_bilet_satis/services/auth_service.dart';
import 'package:online_bilet_satis/services/dio_client.dart';
import 'package:online_bilet_satis/views/home/trip_screen.dart';
import 'package:online_bilet_satis/views/profile/user_screen.dart';
import 'package:online_bilet_satis/models/bus_trip.dart';
import 'package:online_bilet_satis/views/booking/trip_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/trip_provider.dart';
import '../../services/api_service.dart';

class HomeScreen extends StatelessWidget {
  final authService = AuthService(DioClient());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Ekran"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen()),
                );
              },
              child: Text("Profile"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TripScreen()),
                );
              },
              child: Text("Seferler"),
            ),
          ],
        ),
      ),
    );
  }
}
