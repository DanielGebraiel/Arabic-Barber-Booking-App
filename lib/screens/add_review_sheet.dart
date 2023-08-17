import 'package:barber_booking_flutter/components/review_slider.dart';
import 'package:barber_booking_flutter/components/review_text_box.dart';
import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/utilities/database_handler.dart';
import 'package:barber_booking_flutter/constants.dart';
import 'package:barber_booking_flutter/components/rounded_button.dart';

class AddReviewSheet extends StatefulWidget {
  const AddReviewSheet({super.key, required this.userName});

  final String userName;

  @override
  State<AddReviewSheet> createState() => _AddReviewSheetState();
}

class _AddReviewSheetState extends State<AddReviewSheet> {
  String reviewDescription = '';
  int numOfReviewStars = 0;
  DatabaseHandler databaseHandler = DatabaseHandler();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGreyColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
            child: Text(
              '! ' 'اخبرنا عن زيارتك',
              textAlign: TextAlign.center,
              style: kWhiteFontTitleTextStyle,
            ),
          ),
          Flexible(
            child: Text('$numOfReviewStars/5', style: reviewNumberTextStyle),
          ),
          Flexible(
              child: ReviewSlider(
                  onChangedCallBack: (double newValue) {
                    setState(() {
                      numOfReviewStars = newValue.toInt();
                    });
                  },
                  numOfReviewStars: numOfReviewStars)),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ReviewTextBox(
                onChangedCallBack: (newValue) {
                  reviewDescription = newValue;
                },
              ),
            ),
          ),
          const Flexible(
            child: SizedBox(
              height: 30,
            ),
          ),
          Flexible(
            child: RoundedButton(
              buttonText: 'الغاء',
              onPressed: () {
                Navigator.pop(context);
              },
              buttonColor: kWhitishColor,
              textColor: kGreyColor,
            ),
          ),
          const Flexible(
            child: SizedBox(
              height: 20,
            ),
          ),
          Flexible(
            child: RoundedButton(
              buttonText: 'ارسال',
              onPressed: () async {
                if (numOfReviewStars != 0) {
                  Map<String, dynamic> reviewData = {
                    'numOfStars': numOfReviewStars,
                    'description': reviewDescription,
                    'name': widget.userName
                  };
                  await databaseHandler.sendReview(reviewData);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
              buttonColor: kWhitishColor,
              textColor: kGoldenColor,
            ),
          )
        ],
      ),
    );
  }
}
