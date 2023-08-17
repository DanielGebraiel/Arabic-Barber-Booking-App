import 'package:barber_booking_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:barber_booking_flutter/components/review_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewReviewsScreen extends StatelessWidget {
  const ViewReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    FirebaseFirestore _store = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: kGreyColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_upward,
                  color: kWhitishColor, size: 40),
              onPressed: () => Navigator.pop(context),
            ),
            const Text(
              'اخر التقيمات',
              textAlign: TextAlign.center,
              style: kWhiteFontTitleTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            ReviewStream(firestore: _store)
          ],
        ),
      ),
    );
  }
}

class ReviewStream extends StatelessWidget {
  const ReviewStream({super.key, required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.collection('reviews').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text(
            'لا يوجد تقيمات',
            style: TextStyle(
                fontSize: 30,
                color: kWhitishColor,
                fontWeight: FontWeight.bold),
          );
        }
        final reviews = snapshot.data!.docs;
        List<ReviewCard> reviewCards = [];
        for (var review in reviews) {
          final nameOfReviewer = review['name'];
          final numOfStars = review['numOfStars'];
          final reviewDescription = review['description'];
          ReviewCard newCard = ReviewCard(
              nameOfReviewer: nameOfReviewer,
              numOfStars: numOfStars,
              reviewDescription: reviewDescription);
          reviewCards.add(newCard);
        }
        return Expanded(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: reviewCards.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return reviewCards[index];
              },
            ),
          ),
        );
      },
    );
  }
}
