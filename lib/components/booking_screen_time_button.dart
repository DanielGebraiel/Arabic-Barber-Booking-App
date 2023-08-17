import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/constants.dart';

class BookingScreenTimeButton extends StatelessWidget {
  const BookingScreenTimeButton(
      {super.key, required this.buttonTime, required this.onPressedCallBack});

  final String buttonTime;
  final Function() onPressedCallBack;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressedCallBack;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kWhitishColor,
        elevation: 0,
        minimumSize: const Size(100, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
      child: Text(
        buttonTime,
        style: const TextStyle(
            fontSize: 18, color: kGreyColor, fontWeight: FontWeight.w600),
      ),
    );
  }
}
