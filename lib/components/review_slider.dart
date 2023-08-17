import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/constants.dart';

class ReviewSlider extends StatelessWidget {
  const ReviewSlider({super.key, required this.onChangedCallBack,required this.numOfReviewStars});

  final Function(double newValue)? onChangedCallBack;
  final int numOfReviewStars;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: kGoldenColor,
          inactiveTrackColor: kBeigeColor,
          thumbColor: kGoldenColor,
          overlayColor: kOverlayGoldColor,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        ),
        child: Slider(
          min: 0,
          max: 5,
          value: numOfReviewStars.toDouble(),
          onChanged: onChangedCallBack
        ),
      ),
    );
  }
}
