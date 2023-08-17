import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/constants.dart';
import 'package:barber_booking_flutter/utilities/service_icon_type.dart';

class ServiceIcon extends StatelessWidget {
  const ServiceIcon(
      {super.key, required this.iconType,
      this.backgroundColor = kBeigeColor,
      this.radius = 37,
      this.borderColor = kGreyColor
      });

  final String iconType;
  final Color backgroundColor;
  final Color borderColor;
  final double radius;

  String get _nameInArabic {
    if (iconType == ServiceIconType.hairCut.name) {
      return 'قص الشعر';
    } else if (iconType == ServiceIconType.facialHair.name) {
      return 'شعر الوجه';
    } else if (iconType == ServiceIconType.facialMask.name) {
      return 'قناع الوجه';
    } else if (iconType == ServiceIconType.hairDye.name) {
      return 'صبغة شعر';
    } else if (iconType == ServiceIconType.manicure.name) {
      return 'مانيكور';
    } else if (iconType == ServiceIconType.shaving.name) {
      return 'حلاقة';
    } else {
      return 'قص الشعر';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: borderColor,
          radius: 1.04*radius,
          child: CircleAvatar(
            backgroundColor: backgroundColor,
            radius: radius - 3,
            child: Image(
              width: radius + 10,
              image: AssetImage('images/$iconType.png'),
              color: borderColor,
            ),
          ),
        ),
        Text(
          _nameInArabic,
          textAlign: TextAlign.center,
          style: kServiceIconTextStyle.copyWith(fontSize: radius-24),
        )
      ],
    );
  }
}
