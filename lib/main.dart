import 'package:barber_booking_flutter/screens/barber_screen.dart';
import 'package:barber_booking_flutter/screens/login_screen.dart';
import 'package:barber_booking_flutter/screens/registration_screen.dart';
import 'package:barber_booking_flutter/screens/service_screen.dart';
import 'package:barber_booking_flutter/screens/user_booked_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const BarberBooker());
}

class BarberBooker extends StatelessWidget {
  const BarberBooker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSansArabic'),
      routes: {
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        ServiceScreen.id: (context) => const ServiceScreen(),
        BarberScreen.id: (context) => const BarberScreen(),
        UserBookedScreen.id: (context) => const UserBookedScreen()
      },
      initialRoute: LoginScreen.id,
    );
  }
}
