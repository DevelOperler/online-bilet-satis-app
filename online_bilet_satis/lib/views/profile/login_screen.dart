import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:online_bilet_satis/services/auth_service.dart';
import 'package:online_bilet_satis/services/dio_client.dart';
import 'package:provider/provider.dart';

import '../../providers/ticket_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = AuthService(DioClient());
    final ticketProvider = Provider.of<TicketProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Login işleminden token al
                  final token = await authService.login(
                    emailController.text,
                    passwordController.text,
                  );
                  // Token'i çözümle ve userId'yi al
                  final decodedToken = JwtDecoder.decode(token);
                  final userId = decodedToken[
                      'user_id']; // Backend'e göre 'userId' key'i değişebilir

                  // Kullanıcının oturum bilgisini TicketProvider'a ilet
                  ticketProvider.setCurrentUser(userId);
                  Navigator.pushReplacementNamed(context, '/home');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login failed: ${e.toString()}')),
                  );
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
