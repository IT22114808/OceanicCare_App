import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Function to add feedback to Firestore
  Future<bool> addFeedback(Map<String, dynamic> feedbackInfoMap) async {
    try {
      // Generate a unique ID for the feedback document
      String id = FirebaseFirestore.instance.collection("feedbacks").doc().id;

      await FirebaseFirestore.instance
          .collection("feedbacks")
          .doc(id)
          .set(feedbackInfoMap);

      // Return true if successful
      return true;
    } catch (e) {
      // Log the error
      print('Error adding feedback: $e');
      return false; // Return false if an error occurred
    }
  }
}
