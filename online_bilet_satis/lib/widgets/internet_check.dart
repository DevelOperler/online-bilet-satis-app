import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class ConnectivityCheckWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityCheckWrapper({Key? key, required this.child})
      : super(key: key);

  @override
  _ConnectivityCheckWrapperState createState() =>
      _ConnectivityCheckWrapperState();
}

class _ConnectivityCheckWrapperState extends State<ConnectivityCheckWrapper> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();

    // İlk bağlantı durumunu kontrol et
    _checkInitialConnectivity();

    // Bağlantı durumundaki değişiklikleri dinle
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (results.contains(ConnectivityResult.none)) {
        _showNoConnectionDialog(); // Bağlantı kesilirse kullanıcıyı uyar
        setState(() {
          isOffline = true;
        });
      } else {
        setState(() {
          isOffline = false;
        });
      }
    });
  }

  Future<void> _checkInitialConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showNoConnectionDialog();
      setState(() {
        isOffline = true;
      });
    }
  }

  void _showNoConnectionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Bağlantı Hatası'),
        content: const Text(
            'İnternet bağlantınız kesildi. Lütfen bağlanmayı deneyin.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel(); // Dinleyiciyi iptal et
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isOffline
        ? const Scaffold(
            body: Center(
              child: Text(
                'Bağlantı Yok. Lütfen bağlantıyı kontrol edin.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        : widget.child; // Eğer bağlantı varsa, ana içerik gösterilir
  }
}
