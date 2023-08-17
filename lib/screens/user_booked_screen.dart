import 'package:barber_booking_flutter/screens/login_screen.dart';
import 'package:barber_booking_flutter/screens/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:barber_booking_flutter/components/rounded_button.dart';
import 'package:barber_booking_flutter/components/booking_information_card.dart';
import 'package:barber_booking_flutter/utilities/database_handler.dart';
import 'add_review_sheet.dart';

class UserBookedScreen extends StatefulWidget {
  const UserBookedScreen({super.key});
  static const String id = 'user_booked_screen';

  @override
  State<UserBookedScreen> createState() => _UserBookedScreenState();
}

class _UserBookedScreenState extends State<UserBookedScreen> {
  String userName = '';
  bool showSpinner = false;
  String errorMessage = '';
  bool showErrorMessage = false;
  DatabaseHandler databaseHandler = DatabaseHandler();

  List<String> bookedServices = [];
  DateTime bookedTime = DateTime.now();

  void getUserName() async {
    String name = await databaseHandler.getUserName();
    setState(() {
      userName = name;
    });
  }

  void getBookingInformation() async {
    Map<String, dynamic>? bookingData =
        await databaseHandler.getBookingInformation();
    if (bookingData == null) {
      // ignore: use_build_context_synchronously
      await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (context) => AddReviewSheet(
          userName: userName,
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.popUntil(
        context,
        ModalRoute.withName(LoginScreen.id),
      );
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, ServiceScreen.id);
    } else {
      setState(() {
        bookedServices = bookingData['bookedServices'];
        bookedTime = bookingData['bookedTime'];
      });
    }
  }

  @override
  void initState() {
    setState(() {
      showSpinner = true;
    });
    getUserName();
    getBookingInformation();
    setState(() {
      showSpinner = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                color: kGreyColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () async {
                            await databaseHandler.signUserOut();
                            // ignore: use_build_context_synchronously
                            Navigator.popUntil(
                                context, ModalRoute.withName(LoginScreen.id));
                          },
                          icon: const Icon(
                            Icons.close,
                            color: kBeigeColor,
                            size: 40,
                          ),
                        ),
                      ),
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text('! $userName',
                                style: kWhiteFontTitleTextStyle),
                          ),
                          const Text('  مرحباً ',
                              style: kWhiteFontSubTitleTextStyle),
                        ],
                      ),
                      Flexible(
                        child: BookingInformationCard(
                          bookedServices: bookedServices,
                          bookedTime: bookedTime,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                color: kWhitishColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("! " 'تم الحجز',
                          textAlign: TextAlign.end,
                          style: kGreyFontTitleTextStyle),
                      const Image(
                        image: AssetImage(
                          'images/barberChair.png',
                        ),
                        height: 160,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RoundedButton(
                        buttonText: 'تعديل الحجز',
                        onPressed: () {
                          Navigator.pushNamed(context, ServiceScreen.id);
                        },
                        buttonColor: kGreyColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        buttonText: 'الغاء الحجز',
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            await databaseHandler.deleteLastAppointment();
                          } catch (e) {
                            return;
                          }
                          // ignore: use_build_context_synchronously
                          Navigator.popUntil(
                              context, ModalRoute.withName(LoginScreen.id));
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, ServiceScreen.id);
                          setState(() {
                            showSpinner = false;
                          });
                        },
                        buttonColor: kGreyColor,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

