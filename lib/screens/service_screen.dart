import 'package:barber_booking_flutter/components/service_icon_button.dart';
import 'package:barber_booking_flutter/utilities/service_icon_type.dart';
import 'package:barber_booking_flutter/components/rounded_button.dart';
import 'package:barber_booking_flutter/constants.dart';
import 'package:barber_booking_flutter/screens/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:barber_booking_flutter/utilities/database_handler.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});
  static const String id = 'service_screen';

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  User? loggedInUser;
  String userName = '';
  bool showSpinner = false;
  String errorMessage = '';
  bool showErrorMessage = false;
  DatabaseHandler databaseHandler = DatabaseHandler();

  bool hairCutSelected = false;
  bool facialHairSelected = false;
  bool facialMaskSelected = false;
  bool hairDyeSelected = false;
  bool manicureSelected = false;
  bool shavingSelected = false;

  List<String> bookedServices = [];

  void getUserName() async {
    String name = await databaseHandler.getUserName();
    setState(() {
      userName = name;
    });
  }

  @override
  void initState() {
    setState(() {
      showSpinner = true;
    });
    getUserName();
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
                            Navigator.pop(context);
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
                            child: Text(
                              '! $userName',
                              style: kWhiteFontTitleTextStyle
                            ),
                          ),
                          const Text(
                            '  مرحباً ',
                            style:
                                kWhiteFontSubTitleTextStyle
                          ),
                        ],
                      ),
                      const Text(
                        'اختار من الخدمات بالاسفل لحجز ميعاد',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: kServiceScreenInstructionTextStyle
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
                      const Text(
                        'الخدمات',
                        textAlign: TextAlign.end,
                        style: kGreyFontTitleTextStyle
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ServiceIconButton(
                                iconType: ServiceIconType.hairCut.name,
                                radius: 40,
                                selected: hairCutSelected,
                                onTapCallBack: () {
                                  setState(() {
                                    if (bookedServices.length == 3 &&
                                        !hairCutSelected) {
                                      errorMessage =
                                          'عفوا لا يمكنك الحجز اكثر من ثلاث خدمات';
                                      showErrorMessage = true;
                                      return;
                                    }
                                    showErrorMessage = false;

                                    hairCutSelected
                                        ? bookedServices.remove(
                                            ServiceIconType.hairCut.name,
                                          )
                                        : bookedServices.add(
                                            ServiceIconType.hairCut.name,
                                          );
                                    hairCutSelected = !hairCutSelected;
                                  });
                                },
                              ),
                              ServiceIconButton(
                                iconType: ServiceIconType.facialHair.name,
                                radius: 40,
                                selected: facialHairSelected,
                                onTapCallBack: () {
                                  setState(() {
                                    if (bookedServices.length == 3 &&
                                        !facialHairSelected) {
                                      errorMessage =
                                          'عفوا لا يمكنك الحجز اكثر من ثلاث خدمات';
                                      showErrorMessage = true;
                                      return;
                                    }
                                    showErrorMessage = false;

                                    facialHairSelected
                                        ? bookedServices.remove(
                                            ServiceIconType.facialHair.name,
                                          )
                                        : bookedServices.add(
                                            ServiceIconType.facialHair.name,
                                          );
                                    facialHairSelected = !facialHairSelected;
                                  });
                                },
                              ),
                              ServiceIconButton(
                                iconType: ServiceIconType.shaving.name,
                                radius: 40,
                                selected: shavingSelected,
                                onTapCallBack: () {
                                  setState(() {
                                    if (bookedServices.length == 3 &&
                                        !shavingSelected) {
                                      errorMessage =
                                          'عفوا لا يمكنك الحجز اكثر من ثلاث خدمات';
                                      showErrorMessage = true;
                                      return;
                                    }
                                    showErrorMessage = false;

                                    shavingSelected
                                        ? bookedServices.remove(
                                            ServiceIconType.shaving.name,
                                          )
                                        : bookedServices.add(
                                            ServiceIconType.shaving.name,
                                          );
                                    shavingSelected = !shavingSelected;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ServiceIconButton(
                                iconType: ServiceIconType.facialMask.name,
                                radius: 40,
                                selected: facialMaskSelected,
                                onTapCallBack: () {
                                  setState(() {
                                    if (bookedServices.length == 3 &&
                                        !facialMaskSelected) {
                                      errorMessage =
                                          'عفوا لا يمكنك الحجز اكثر من ثلاث خدمات';
                                      showErrorMessage = true;
                                      return;
                                    }
                                    showErrorMessage = false;

                                    facialMaskSelected
                                        ? bookedServices.remove(
                                            ServiceIconType.facialMask.name,
                                          )
                                        : bookedServices.add(
                                            ServiceIconType.facialMask.name,
                                          );
                                    facialMaskSelected = !facialMaskSelected;
                                  });
                                },
                              ),
                              ServiceIconButton(
                                iconType: ServiceIconType.hairDye.name,
                                radius: 40,
                                selected: hairDyeSelected,
                                onTapCallBack: () {
                                  setState(() {
                                    if (bookedServices.length == 3 &&
                                        !hairDyeSelected) {
                                      errorMessage =
                                          'عفوا لا يمكنك الحجز اكثر من ثلاث خدمات';
                                      showErrorMessage = true;
                                      return;
                                    }

                                    showErrorMessage = false;

                                    hairDyeSelected
                                        ? bookedServices.remove(
                                            ServiceIconType.hairDye.name,
                                          )
                                        : bookedServices.add(
                                            ServiceIconType.hairDye.name,
                                          );
                                    hairDyeSelected = !hairDyeSelected;
                                  });
                                },
                              ),
                              ServiceIconButton(
                                iconType: ServiceIconType.manicure.name,
                                radius: 40,
                                selected: manicureSelected,
                                onTapCallBack: () {
                                  setState(() {
                                    if (bookedServices.length == 3 &&
                                        !manicureSelected) {
                                      errorMessage =
                                          'عفوا لا يمكنك الحجز اكثر من ثلاث خدمات';
                                      showErrorMessage = true;
                                      return;
                                    }
                                    showErrorMessage = false;

                                    manicureSelected
                                        ? bookedServices.remove(
                                            ServiceIconType.manicure.name,
                                          )
                                        : bookedServices.add(
                                            ServiceIconType.manicure.name,
                                          );
                                    manicureSelected = !manicureSelected;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: Visibility(
                            visible: showErrorMessage,
                            child: Text(
                              errorMessage,
                              textAlign: TextAlign.center,
                              style: kErrorMessageTextStyle,
                            )),
                      ),
                      RoundedButton(
                        buttonText: 'احجز الآن',
                        onPressed: () {
                          setState(() {
                            if (bookedServices.isEmpty) {
                              errorMessage =
                                  'عفوا يجب الاختيار علي الاقل خدمة واحدة';
                              showErrorMessage = true;
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingScreen(
                                    bookedServices: bookedServices),
                              ),
                            );
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
