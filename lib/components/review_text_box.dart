import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/constants.dart';

class ReviewTextBox extends StatelessWidget {
  const ReviewTextBox({super.key, required this.onChangedCallBack});

  final Function(String newValue) onChangedCallBack;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 4,
      onChanged: onChangedCallBack,
      textAlign: TextAlign.right,
      decoration: const InputDecoration(
        hintText: 'اخبرنا عن رأيك',
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: kWhitishColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kGoldenColor, width: 6),
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kGoldenColor, width: 6),
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
      ),
    );
  }
}
