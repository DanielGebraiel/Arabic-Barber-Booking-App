import 'package:barber_booking_flutter/components/service_icon.dart';
import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/constants.dart';

class ServiceIconButton extends StatelessWidget {
  const ServiceIconButton(
      {super.key, required this.iconType,
      this.backgroundColor = kWhitishColor,
      this.radius = 37,
      this.selected = false,
      required this.onTapCallBack});

  final String iconType;
  final Color backgroundColor;
  final double radius;
  final bool selected;
  final Function() onTapCallBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallBack,
      child: ServiceIcon(
        iconType: iconType,
        radius: radius,
        borderColor: selected? kGoldenColor: kGreyColor,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
