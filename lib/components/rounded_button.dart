import 'package:barber_booking_flutter/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key, required this.buttonText,
      required this.onPressed,
      this.buttonColor = kGoldenColor,
      this.textColor = kWhitishColor});

  final String buttonText;
  final Function() onPressed;
  final Color buttonColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: buttonColor,
        fixedSize: const Size(250, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }
}
