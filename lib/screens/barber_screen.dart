import 'package:barber_booking_flutter/components/barber_view_appointment_card.dart';
import 'package:barber_booking_flutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BarberScreen extends StatefulWidget {
  const BarberScreen({super.key});
  static const String id = 'barber_screen';

  @override
  State<BarberScreen> createState() => _BarberScreenState();
}

class _BarberScreenState extends State<BarberScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              color: kWhitishColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: kGreyColor,
                            size: 40,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'حجوزات',
                          style: kGreyFontSubTitleTextStyle.copyWith(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'مشط و مقص',
                        style: kGreyFontTitleTextStyle.copyWith(height: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: kGreyColor,
              child: AppointmentStream(
                firestore: _firestore,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppointmentStream extends StatelessWidget {
  const AppointmentStream({super.key, required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore
          .collection('appointments')
          .where('bookedTime', isGreaterThan: DateTime.now())
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text(
            'لا يوجد حجوزات',
            style: TextStyle(
                fontSize: 30,
                color: kWhitishColor,
                fontWeight: FontWeight.bold),
          );
        }
        final appointments = snapshot.data!.docs;
        List<BarberViewAppointmentCard> appointmentCards = [];
        for (var appointment in appointments) {
          final userName = appointment['bookerName'];
          final phoneNumber = appointment['phoneNumber'];
          List bookedServicesData = appointment['services'];
          final List<String> bookedServices = [];
          for (var service in bookedServicesData) {
            bookedServices.add(service.toString());
          }
          Timestamp bookedTimeData = appointment['bookedTime'];
          DateTime bookedTime = bookedTimeData.toDate();
          BarberViewAppointmentCard newCard = BarberViewAppointmentCard(
              bookedServices: bookedServices,
              bookedTime: bookedTime,
              bookerName: userName,
              bookerPhoneNumber: phoneNumber);
          appointmentCards.add(newCard);
        }
        return ListView(
          children: appointmentCards,
        );
      },
    );
  }
}
