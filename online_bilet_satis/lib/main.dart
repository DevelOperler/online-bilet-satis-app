import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:online_bilet_satis/models/bus_ticket.dart';
import 'package:online_bilet_satis/models/bus_trip.dart';
import 'package:online_bilet_satis/models/seat.dart';
import 'package:online_bilet_satis/providers/ticket_provider.dart';
import 'package:online_bilet_satis/views/profile/login_screen.dart';
import 'package:online_bilet_satis/views/profile/register_screen.dart';
import 'package:online_bilet_satis/views/profile/splash_screen.dart';
import 'package:online_bilet_satis/widgets/internet_check.dart';
import 'package:provider/provider.dart';
import 'providers/trip_provider.dart';
import 'providers/seat_provider.dart';
import 'views/home/home_screen.dart';
import 'services/notification_service.dart';
import 'package:workmanager/workmanager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NotificationService başlatma

  // Timezone başlatma
  tz.initializeTimeZones();
  // Hive'ı başlat
  await Hive.initFlutter();

  // Hive Adapter'ları burada kaydedebilirsiniz
  Hive.registerAdapter(BusTripAdapter()); // Eğer kullanıyorsanız
  Hive.registerAdapter(SeatAdapter()); // Eğer kullanıyorsanız
  Hive.registerAdapter(BusTicketAdapter()); // Eğer kullanıyorsanız

  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  // Bildirim izni kontrol ve talep etme
  await requestNotificationPermission();

  final notificationService = NotificationService();
  await notificationService.initNotification();

  // WorkManager başlatma
  Workmanager().initialize(callbackDispatcher);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TripProvider()),
        ChangeNotifierProvider(create: (_) => SeatProvider()),
        ChangeNotifierProvider(create: (_) => TicketProvider()),
      ],
      child: MyApp(),
    ),
  );
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    print("Arka plan görevi çalıştı: $taskName"); // LOG EKLENDİ

    final notificationService = NotificationService();
    await notificationService.showNotification(
      id: 1,
      title: 'Biletiniz Yaklaşıyor!',
      body: 'Sefer saatinize 5 dakika kaldı. Hazırlıklarınızı yapın!',
    );
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Bilet Satış',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ConnectivityCheckWrapper(child: SplashScreen()),
        // '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
