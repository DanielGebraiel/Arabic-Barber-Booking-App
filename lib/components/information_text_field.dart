import 'package:barber_booking_flutter/constants.dart';
import 'package:flutter/material.dart';

class InformationTextField extends StatelessWidget {
  const InformationTextField(
      {super.key, required this.hintText, required this.onChangedCallBack, this.obscureText = false});

  final String hintText;
  final Function(String) onChangedCallBack;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: TextField(
        onChanged: onChangedCallBack,
        obscureText: obscureText,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: kWhitishColor,
          filled: true,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kGoldenColor, width: 8),
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kGoldenColor, width: 8),
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
        ),
      ),
    );
  }
}
