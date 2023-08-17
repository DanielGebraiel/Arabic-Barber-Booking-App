import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/constants.dart';
import 'booking_information_card.dart';

class BarberViewAppointmentCard extends StatelessWidget {
  const BarberViewAppointmentCard(
      {super.key, required this.bookedServices,
      required this.bookedTime,
      required this.bookerName,
      required this.bookerPhoneNumber});

  final List<String> bookedServices;
  final DateTime bookedTime;
  final String bookerName;
  final String bookerPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '$bookerName :',
                style: kAppointmentCardNameTextStyle,
              ),
              const Text(
                'من',
                style: kAppointmentCardNameTextStyle,
              )
            ],
          ),
        ),
        BookingInformationCard(
            bookedServices: bookedServices, bookedTime: bookedTime),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.phone,
              color: kWhitishColor,
            ),
            Text(
              '  $bookerPhoneNumber',
              style: kAppointmentCardPhoneNumberTextStyle,
            )
          ],
        )
      ],
    );
  }
}
