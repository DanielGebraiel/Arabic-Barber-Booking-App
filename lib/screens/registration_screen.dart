import 'package:barber_booking_flutter/components/information_text_field.dart';
import 'package:barber_booking_flutter/components/rounded_button.dart';
import 'package:barber_booking_flutter/constants.dart';
import 'package:barber_booking_flutter/screens/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:barber_booking_flutter/utilities/database_handler.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void dispose() {
    showSpinner = false;
    super.dispose();
  }

  String email = '';
  String password = '';
  String phoneNumber = '';
  String userName = '';
  String errorMessage = '';
  bool showErrorMessage = false;
  DatabaseHandler databaseHandler = DatabaseHandler();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: IconButton(
                      alignment: Alignment.bottomLeft,
                      icon: const Icon(
                        Icons.arrow_back,
                        color: kWhitishColor,
                        size: 40,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Hero(
                        tag: 'logo',
                        child: Image(
                          color: kWhitishColor,
                          width: 100,
                          height: 100,
                          image: AssetImage('images/mustache.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Text(
                '! انضم إلينا',
                textAlign: TextAlign.center,
                style: kLoginRegistrationTitleTextStyle.copyWith(fontSize: 50),
              ),
            ),
            SizedBox(
              height: 40,
              child: Visibility(
                visible: showErrorMessage,
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  // 'عفوا هذا البريد مستخدم',
                  style: kErrorMessageTextStyle,
                ),
              ),
            ),
            InformationTextField(
              hintText: 'أدخل أسمك',
              onChangedCallBack: (String newValue) {
                userName = newValue;
              },
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
            InformationTextField(
              hintText: 'أدخل رقم هاتفك',
              onChangedCallBack: (String newValue) {
                phoneNumber = newValue;
              },
            ),
            const SizedBox(height: 30),
            RoundedButton(
              buttonText: 'سجل',
              onPressed: () async {
                if (userName == '' ||
                    email == '' ||
                    password == '' ||
                    phoneNumber == '') {
                  setState(
                    () {
                      errorMessage = 'عفوا برجاء املاء جميع الخانات ';
                      showErrorMessage = true;
                    },
                  );
                  return;
                }
                if (password.length < 6) {
                  setState(
                    () {
                      errorMessage =
                          'عفوا يجب ان تكون كلمة \n السر اكثر من ستة احرف';
                      showErrorMessage = true;
                    },
                  );
                  return;
                }
                if (userName.length > 12) {
                  setState(
                    () {
                      errorMessage = 'عفوا يجب ان يكون الاسم اقل من 12 حرف';
                      showErrorMessage = true;
                    },
                  );
                  return;
                }
                if (phoneNumber.length != 11) {
                  setState(
                    () {
                      errorMessage = 'عفوا يجب ان يكون رقم الهاتف 11 رقم';
                      showErrorMessage = true;
                    },
                  );
                  return;
                }
                try {
                  setState(() {
                    showSpinner = true;
                  });
                  await databaseHandler.registerUser(email, password);
                  Map<String, dynamic> userData = {
                    'email': email,
                    'name': userName,
                    'phoneNumber': phoneNumber,
                    'hasBooked': false,
                  };
                  databaseHandler.registerUserData(userData);
                } catch (e) {
                  setState(
                    () {
                      showSpinner = false;
                      errorMessage = 'عذرا حدث خطأ يرجى المحاولة مرة أخرى';
                      showErrorMessage = true;
                      return;
                    },
                  );
                }
                setState(() {
                  showSpinner = false;
                  showErrorMessage = false;
                });
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, ServiceScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
