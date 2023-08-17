import 'package:barber_booking_flutter/constants.dart';
import 'package:barber_booking_flutter/screens/barber_screen.dart';
import 'package:barber_booking_flutter/screens/registration_screen.dart';
import 'package:barber_booking_flutter/screens/service_screen.dart';
import 'package:barber_booking_flutter/screens/user_booked_screen.dart';
import 'package:barber_booking_flutter/screens/view_reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/components/information_text_field.dart';
import 'package:barber_booking_flutter/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      //upperBound: 100
    );

    animation = CurvedAnimation(curve: Curves.decelerate, parent: controller!);

    controller!.repeat();
    controller!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  String email = '';
  String password = '';
  String errorMessage = '';
  bool showErrorMessage = false;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dy < -sensitivity) {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            context: context,
            builder: (context) => const ViewReviewsScreen(),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF333333),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Image(
                    height: 200,
                    width: 200,
                    color: kWhitishColor,
                    image: AssetImage(
                      'images/mustache.png',
                    ),
                  ),
                ),
              ),
              const Text(
                'مشط و مقص',
                textAlign: TextAlign.center,
                style: kLoginRegistrationTitleTextStyle,
              ),
              SizedBox(
                height: 50,
                child: Visibility(
                  visible: showErrorMessage,
                  child: Text(errorMessage, style: kErrorMessageTextStyle),
                ),
              ),
              InformationTextField(
                hintText: 'أدخل بريدك الإلكتروني',
                onChangedCallBack: (String newValue) {
                  email = newValue;
                },
              ),
              InformationTextField(
                obscureText: true,
                hintText: 'ادخل كلمة السر',
                onChangedCallBack: (String newValue) {
                  password = newValue;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              RoundedButton(
                buttonText: 'تسجيل الدخول',
                onPressed: () async {
                  if (email == '' || password == '') {
                    // 'عفوا يوجد خطأ في البريد الالكتروني او كلمة السر',
                    errorMessage = 'عفوا برجاء املاء جميع الخانات ';
                    setState(() {
                      showErrorMessage = true;
                    });
                    return;
                  }
                  if (email == 'barber' && password == 'barber123') {
                    setState(() {
                      showErrorMessage = false;
                    });
                    Navigator.pushNamed(context, BarberScreen.id);
                    return;
                  }
                  try {
                    setState(() {
                      showSpinner = true;
                    });
                    await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                  } catch (e) {
                    setState(
                      () {
                        showSpinner = false;
                        errorMessage = 'عذرا يوجد خطأ في البريد او كلمة السر';
                        showErrorMessage = true;
                      },
                    );
                    return;
                  }
                  setState(() {
                    showSpinner = false;
                    showErrorMessage = false;
                  });
                  var userInformation = await _fireStore
                      .collection('usersInformation')
                      .where('email', isEqualTo: email)
                      .get();
                  bool hasBooked = userInformation.docs[0]['hasBooked'];

                  if (hasBooked) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, UserBookedScreen.id);
                  } else {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, ServiceScreen.id);
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showErrorMessage = false;
                      });
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                    child: const Text('اضغط هنا',
                        style: kNormalFontSizeTextStyleGold),
                  ),
                  const Text(
                    '|  غير مسجل؟',
                    style: kNormalFontSizeTextStyleWhite,
                  ),
                ],
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 30 * controller!.value),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        context: context,
                        builder: (context) => const ViewReviewsScreen(),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_downward,
                      size: 40,
                      color: kWhitishColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
