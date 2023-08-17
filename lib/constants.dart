import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

const kLoginRegistrationTitleTextStyle = TextStyle(
    color: kWhitishColor,
    fontSize: 57,
    fontFamily: 'NotoSansArabic',
    fontWeight: FontWeight.bold);

const TextStyle kNormalFontSizeTextStyleWhite =
    TextStyle(color: kWhitishColor, fontSize: 16);

const TextStyle kNormalFontSizeTextStyleGold =
    TextStyle(color: kGoldenColor, fontSize: 16);

const TextStyle kServiceIconTextStyle = TextStyle(
    color: kGreyColor,
    height: 1.8,
    fontSize: 14.5,
    fontWeight: FontWeight.w600);

const Color kGoldenColor = Color(0xFFe28d38);

const Color kOverlayGoldColor = Color(0x29e28d38);

const Color kGreyColor = Color(0xFF333333);

const Color kBeigeColor = Color(0xFFf6e1b6);

const Color kWhitishColor = Color(0xFFfff6e5);

const TextStyle reviewNumberTextStyle = TextStyle(
    height: 2, color: kGoldenColor, fontSize: 40, fontWeight: FontWeight.bold);

const TextStyle kErrorMessageTextStyle =
    TextStyle(color: Colors.red, fontSize: 19, fontWeight: FontWeight.w600);

const TextStyle kArabicDayTextStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

const TextStyle kWhiteFontTitleTextStyle =
    TextStyle(color: kWhitishColor, fontSize: 38, fontWeight: FontWeight.bold);

const TextStyle kWhiteFontSubTitleTextStyle =
    TextStyle(color: kWhitishColor, fontSize: 23);

const TextStyle kServiceScreenInstructionTextStyle = TextStyle(
    height: 1.5,
    color: kGoldenColor,
    fontSize: 38,
    fontWeight: FontWeight.w600);

const TextStyle kGreyFontTitleTextStyle =
    TextStyle(color: kGreyColor, fontSize: 40, fontWeight: FontWeight.bold);

const TextStyle kGreyFontSubTitleTextStyle =
    TextStyle(color: kGreyColor, fontSize: 23);

const TextStyle kBookingScreenInstructionTextStyle =
    TextStyle(height: 1, color: kWhitishColor, fontSize: 27);

const TextStyle kAppointmentCardNameTextStyle =
    TextStyle(color: kWhitishColor, fontSize: 16, fontWeight: FontWeight.w600);

const TextStyle kAppointmentCardPhoneNumberTextStyle =
    TextStyle(color: kWhitishColor, fontSize: 16);

const CalendarStyle kBookingCalendarStyle = CalendarStyle(
    selectedTextStyle: TextStyle(fontSize: 20, color: kGoldenColor),
    isTodayHighlighted: false,
    selectedDecoration:
        BoxDecoration(shape: BoxShape.circle, color: kWhitishColor),
    defaultTextStyle: TextStyle(fontSize: 20),
    disabledTextStyle: TextStyle(fontSize: 20, color: Colors.grey),
    weekendTextStyle: TextStyle(fontSize: 20));

const List<int> kAvailableBookingTimes = [
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23
];

class KArabicCalendarHeader extends StatelessWidget {
  const KArabicCalendarHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          '    الاحد',
          style: kArabicDayTextStyle,
        ),
        Text('    اثنين', style: kArabicDayTextStyle),
        Text('      ثلاثاء', style: kArabicDayTextStyle),
        Text('     اربعاء', style: kArabicDayTextStyle),
        Text('    خميس', style: kArabicDayTextStyle),
        Text('   الجمعة', style: kArabicDayTextStyle),
        Text('    سبت', style: kArabicDayTextStyle),
      ],
    );
  }
}
