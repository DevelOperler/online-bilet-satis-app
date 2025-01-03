import 'package:flutter/material.dart';
import 'package:online_bilet_satis/services/auth_service.dart';
import 'package:online_bilet_satis/services/dio_client.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      final authService = AuthService(DioClient());
      final isLoggedIn = await authService.isLoggedIn();

      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
