import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/constants.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard(
      {super.key, required this.nameOfReviewer,
      required this.numOfStars,
      required this.reviewDescription});

  final int numOfStars;
  final String nameOfReviewer;
  final String reviewDescription;

  List<Icon> getStars() {
    List<Icon> starts = [];
    for (int i = 0; i < numOfStars; i++) {
      starts.add(
        const Icon(
          Icons.star,
          color: kGoldenColor,
          size: 30,
        ),
      );
    }
    return starts;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        //width: double.infinity,
        decoration: const BoxDecoration(
          color: kBeigeColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: getStars()),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  nameOfReviewer,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const Divider(
                color: kGreyColor,
                thickness: 2,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(reviewDescription),
              )
            ],
          ),
        ),
      ),
    );
  }
}
