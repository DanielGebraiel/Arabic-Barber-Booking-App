import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHandler {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<String> getUserName() async {
    final user = _auth.currentUser;
    var userInformation = await _fireStore
        .collection('usersInformation')
        .where('email', isEqualTo: user?.email)
        .get();
    return userInformation.docs[0]['name'];
  }

  Future<void> signUserOut() async {
    await _auth.signOut();
  }

  String getUserEmail() {
    return _auth.currentUser!.email!;
  }

  Future<void> registerUser(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> registerUserData (Map<String,dynamic> userData) async {
    _fireStore.collection('usersInformation').add(userData);
  }

  Future<String> getUserPhoneNumber() async {
    final user = _auth.currentUser;
    var userInformation = await _fireStore
        .collection('usersInformation')
        .where('email', isEqualTo: user?.email)
        .get();
    return userInformation.docs[0]['phoneNumber'];
  }

  Future<bool> bookAppointment(Map<String, dynamic> data) async {
    String? lastUnreviewedAppointmentID =
        await getLastUnreviewedAppointmentID();
    if (lastUnreviewedAppointmentID != null) {
      deleteLastAppointment();
    }
    Timestamp bookedTimeData = data['bookedTime'];
    bookedTimeData =
        Timestamp(bookedTimeData.seconds - 60, bookedTimeData.nanoseconds);
    var appointmentInformation = await _fireStore
        .collection('appointments')
        .where('bookedTime', isGreaterThanOrEqualTo: bookedTimeData)
        .where('bookedTime', isLessThanOrEqualTo: data['bookedTime'])
        .get();
    if (appointmentInformation.docs.isNotEmpty) {
      return false;
    } else {
      _fireStore.collection('appointments').add(data);
      await updateUserHasBooked(true);
      return true;
    }
  }

  Future<Map<String, dynamic>?> getBookingInformation() async {
    var appointmentsData = _fireStore.collection('appointments');
    var appointmentInormation = await appointmentsData
        .where('email', isEqualTo: _auth.currentUser?.email)
        .where('reviewed', isEqualTo: false)
        .get();
    var appointmentData = appointmentInormation.docs[0];
    Timestamp bookedTimeData = appointmentData['bookedTime'];
    DateTime bookedTime = bookedTimeData.toDate();

    if (bookedTime.isBefore(DateTime.now())) {
      await updateUserHasBooked(false);
      await updateHasReviewed(appointmentData.id);
      return null;
    } else {
      List bookedServicesData = appointmentData['services'];
      List<String> bookedServices = [];
      for (var service in bookedServicesData) {
        bookedServices.add(service.toString());
      }
      return {'bookedServices': bookedServices, 'bookedTime': bookedTime};
    }
  }

  Future<void> updateUserHasBooked(bool newBool) async {
    String documentID = await getCurrentUserDocumentID();
    _fireStore
        .collection('usersInformation')
        .doc(documentID)
        .update({'hasBooked': newBool});
  }

  Future<void> updateHasReviewed(String id) async {
    _fireStore.collection('appointments').doc(id).update({'reviewed': true});
  }

  Future<void> sendReview(Map<String, dynamic> reviewData) async {
    _fireStore.collection('reviews').add(reviewData);
  }

  Future<String?> getLastUnreviewedAppointmentID() async {
    var appointmentsData = _fireStore.collection('appointments');
    var appointmentInormation = await appointmentsData
        .where('email', isEqualTo: _auth.currentUser?.email)
        .where('reviewed', isEqualTo: false)
        .get();
    if (appointmentInormation.size == 0) {
      return null;
    }
    return appointmentInormation.docs[0].id;
  }

  Future<String> getCurrentUserDocumentID() async {
    var userInformation = await _fireStore
        .collection('usersInformation')
        .where('email', isEqualTo: _auth.currentUser?.email)
        .get();
    return userInformation.docs[0].id;
  }

  Future<void> deleteLastAppointment() async {
    String? appointmentID = await getLastUnreviewedAppointmentID();
    _fireStore.collection('appointments').doc(appointmentID).delete();
    updateUserHasBooked(false);
  }

  Future getAllFutureBookedAppointments() async {
    var appointmentsData = await _fireStore
        .collection('appointments')
        .where('bookedTime', isGreaterThan: DateTime.now())
        .get();
    return appointmentsData.docs;
  }

  Future getUserNameFromEmail(String email) async {
    var userInformation = await _fireStore
        .collection('usersInformation')
        .where('email', isEqualTo: email)
        .get();
    return userInformation.docs[0]['email'];
  }

  Future getUserNumberFromEmail(String email) async {
    var userInformation = await _fireStore
        .collection('usersInformation')
        .where('email', isEqualTo: email)
        .get();
    return userInformation.docs[0]['phoneNumber'];
  }
}
