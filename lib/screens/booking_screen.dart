import 'package:barber_booking_flutter/components/booking_information_card.dart';
import 'package:barber_booking_flutter/components/rounded_button.dart';
import 'package:barber_booking_flutter/constants.dart';
import 'package:barber_booking_flutter/screens/user_booked_screen.dart';
import 'package:barber_booking_flutter/utilities/database_handler.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.bookedServices});

  static const String id = 'booking_scren';
  final List<String> bookedServices;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DatabaseHandler databaseHandler = DatabaseHandler();

  bool showErrorMessage = false;
  bool showSpinner = false;

  bool firstTime = true;

  DateTime _selectedDay = DateTime.now().hour >= 23
      ? DateTime.now().add(const Duration(days: 1))
      : DateTime.now();

  List<int> availableBookingTimes = [];

  List<Text> getBookingTimes() {
    List<Text> bookingTimes = [];
    availableBookingTimes.clear();
    DateTime currentDay = DateTime.now();
    for (int time in kAvailableBookingTimes) {
      if (time <= currentDay.hour && _selectedDay.day == currentDay.day) {
        continue;
      }
      availableBookingTimes.add(time);
      Text newTime = Text(
        time.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(color: kGreyColor, fontSize: 80),
      );
      bookingTimes.add(newTime);
    }
    if (firstTime) {
      _selectedDay = DateTime(_selectedDay.year, _selectedDay.month,
          _selectedDay.day, availableBookingTimes[0]);
      firstTime = false;
    }
    return bookingTimes;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: kGreyColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 40,
                    color: kWhitishColor,
                  ),
                  const Text('! احجز معنا',
                      textAlign: TextAlign.end,
                      style: kWhiteFontTitleTextStyle),
                ],
              ),
              const Text('اختار الميعاد المناسب لك',
                  textAlign: TextAlign.end,
                  style: kBookingScreenInstructionTextStyle),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 120,
                decoration: const BoxDecoration(
                  color: kBeigeColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(child: KArabicCalendarHeader()),
                    TableCalendar(
                      daysOfWeekVisible: false,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _selectedDay,
                      calendarFormat: CalendarFormat.week,
                      headerVisible: false,
                      daysOfWeekHeight: 70,
                      calendarStyle: kBookingCalendarStyle,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      enabledDayPredicate: (day) {
                        return day.isAfter(DateTime.now()) ||
                            isSameDay(DateTime.now(), day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          showErrorMessage = false;
                          _selectedDay = DateTime(
                              selectedDay.year,
                              selectedDay.month,
                              selectedDay.day,
                              availableBookingTimes[availableBookingTimes.length-1]);
                        });
                      },
                    ),
                  ],
                ),
              ),
              Text(
                'اختار وقت الحجز',
                textAlign: TextAlign.end,
                style: kBookingScreenInstructionTextStyle.copyWith(height: 2.2),
              ),
              SizedBox(
                height: 120,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: kWhitishColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: CupertinoPicker(
                        itemExtent: 90,
                        onSelectedItemChanged: (newHour) {
                          setState(() {
                            showErrorMessage = false;
                            int selectedHourIndex = newHour;
                            _selectedDay = DateTime(
                                _selectedDay.year,
                                _selectedDay.month,
                                _selectedDay.day,
                                availableBookingTimes[selectedHourIndex]);
                          });
                        },
                        children: getBookingTimes(),
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyle(
                          fontSize: 90, height: 1.45, color: kWhitishColor),
                    ),
                    const Text(
                      '00',
                      style: TextStyle(
                          fontSize: 90, height: 1.55, color: kWhitishColor),
                    )
                  ],
                ),
              ),
              const Text(
                'ملخص الحجز',
                textAlign: TextAlign.end,
                style: TextStyle(
                  height: 2,
                  color: kWhitishColor,
                  fontSize: 27,
                ),
              ),
              BookingInformationCard(
                  bookedServices: widget.bookedServices,
                  bookedTime: _selectedDay),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 55,
                child: Visibility(
                  visible: showErrorMessage,
                  child: const Text(
                    'عفوا هذا الميعاد محجوز',
                    textAlign: TextAlign.center,
                    style: kErrorMessageTextStyle,
                  ),
                ),
              ),
              RoundedButton(
                buttonText: 'احجز',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  String email = databaseHandler.getUserEmail();
                  String userName = await databaseHandler.getUserName();
                  String phoneNumber =
                      await databaseHandler.getUserPhoneNumber();
                  Map<String, dynamic> appointmentData = {
                    'reviewed': false,
                    'email': email,
                    'services': widget.bookedServices,
                    'bookedTime': Timestamp.fromDate(_selectedDay),
                    'bookerName': userName,
                    'phoneNumber': phoneNumber
                  };
                  bool successful =
                      await databaseHandler.bookAppointment(appointmentData);
                  setState(() {
                    showSpinner = false;
                  });
                  if (!successful) {
                    setState(() {
                      showErrorMessage = true;
                    });
                    return;
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, UserBookedScreen.id);
                },
                buttonColor: kWhitishColor,
                textColor: kGreyColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
