import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/constants.dart';
import 'service_icon.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class BookingInformationCard extends StatelessWidget {
  const BookingInformationCard({super.key, 
    required this.bookedServices,
    required this.bookedTime,
  });

  final List<String> bookedServices;
  final DateTime bookedTime;

  List<ServiceIcon> getBookedSercivesIcons() {
    List<ServiceIcon> bookedServicesIcons = [];
    for (String service in bookedServices) {
      bookedServicesIcons.add(ServiceIcon(iconType: service));
    }
    return bookedServicesIcons;
  }

  String getDayNameInArabic() {
    String dayinEnglish = DateFormat('EEEE').format(bookedTime);
    switch (dayinEnglish) {
      case 'Monday':
        return 'الاثنين';
      case 'Tuesday':
        return 'الثلاثاء';
      case 'Wednesday':
        return 'الأربعاء';
      case 'Thursday':
        return 'الخميس';
      case 'Friday':
        return 'الجمعة';
      case 'Saturday':
        return 'السبت';
      case 'Sunday':
        return 'الأحد';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            width: 100,
            height: 130,
            decoration: const BoxDecoration(
              color: kGoldenColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    getDayNameInArabic(),
                    style: const TextStyle(
                        height: 0.1,
                        color: kWhitishColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    bookedTime.day.toString(),
                    style: const TextStyle(
                        color: kWhitishColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const Divider(
                    color: kGreyColor,
                    thickness: 3,
                    indent: 20,
                    height: 1,
                  ),
                  Text(
                    '${bookedTime.hour}:00',
                    style: const TextStyle(
                        color: kGreyColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            width: 100,
            height: 130,
            decoration: const BoxDecoration(
              color: kBeigeColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getBookedSercivesIcons(),
            ),
          ),
        )
      ],
    );
  }
}
