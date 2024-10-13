import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'FeedbackForm.dart';

class Feedbacks extends StatelessWidget {
  const Feedbacks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFF1A84D8)), // Updated color
                      iconSize: 24.0,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Text(
                    'Your Feedbacks',
                    style: GoogleFonts.poppins(
                      color: Colors.blue[800], // Updated color
                      fontWeight: FontWeight.bold,
                      fontSize: 28, // Slightly increased font size
                    ),
                  ),
                ],
              ),
            ),
            // Expanded widget to display feedback list
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('feedbacks')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show loading spinner
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No Feedbacks available',
                        style: GoogleFonts.poppins(
                          fontSize: 18, // Slightly increased font size
                          color: Colors.grey[600],
                        ),
                      ),
                    );
                  }

                  // Feedback list view
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // Get feedback data
                      var feedbackData = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;

                      // Feedback details
                      String fullName = feedbackData['fullName'] ?? 'No Name';
                      String email = feedbackData['email'] ?? 'No Email';
                      String title = feedbackData['title'] ?? 'No Title';
                      String message = feedbackData['message'] ?? 'No Message';
                      String docId =
                          snapshot.data!.docs[index].id; // Document ID

                      // Debugging: Print feedback data
                      print(
                          'Feedback from $fullName: $email, $title, $message'); // Added print statement for full details

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white, // White background color
                        elevation:
                            4.0, // Adds elevation to give a shadow effect
                        shadowColor:
                            const Color(0xFF1A84D8), // Blue shadow color
                        child: ListTile(
                          title: Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A84D8), // Updated color
                              fontSize: 18, // Slightly increased font size
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'By: $fullName',
                                style: GoogleFonts.poppins(
                                  fontSize: 16, // Slightly increased font size
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                message,
                                style: GoogleFonts.poppins(
                                  fontSize: 16, // Slightly increased font size
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end, // Align the icons to the right
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Color(0xFF07257C)),
                                onPressed: () {
                                  EditFeedbackDetail(context, docId, fullName,
                                      email, title, message);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red), // Delete icon
                                onPressed: () {
                                  _showDeleteConfirmationDialog(context,
                                      docId); // Show confirmation dialog
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF1A84D8), // Blue color for shadow
              blurRadius: 10, // Normal blur effect
              spreadRadius: 2, // Normal spread effect
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeedbackForm()),
            );
          },
          backgroundColor: Colors.white, // White background for button
          child: const Icon(
            Icons.add,
            color: Color(0xFF1A84D8), // Blue color for plus icon
            size: 32.0, // Adjusted icon size
          ),
        ),
      ),
    );
  }

  // Show confirmation dialog for deletion
  void _showDeleteConfirmationDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Feedback'),
          content: const Text('Are you sure you want to delete this feedback?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteFeedback(docId); // Call delete function
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
              child: const Text('Delete',
                  style: TextStyle(color: Colors.red)), // Delete text in red
            ),
          ],
        );
      },
    );
  }

  // Delete the feedback from Firestore
  void deleteFeedback(String id) {
    FirebaseFirestore.instance.collection('feedbacks').doc(id).delete();
  }

  // Edit Feedback Detail function with text fields
  Future EditFeedbackDetail(BuildContext context, String id, String fullName,
      String email, String title, String message) {
    final TextEditingController nameController =
        TextEditingController(text: fullName);
    final TextEditingController emailController =
        TextEditingController(text: email);
    final TextEditingController titleController =
        TextEditingController(text: title);
    final TextEditingController messageController =
        TextEditingController(text: message);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Edit Feedback",
          style: TextStyle(
            color: Color(0xFF1A84D8), // Blue title color
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: Color(0xFF1A84D8)), // Blue label
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFF1A84D8)), // Blue label
                ),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Color(0xFF1A84D8)), // Blue label
                ),
              ),
              TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  labelText: 'Feedback',
                  labelStyle: TextStyle(color: Color(0xFF1A84D8)), // Blue label
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A84D8), // Blue background
            ),
            onPressed: () {
              // Call the updateFeedback function to save changes to Firestore
              updateFeedback(
                id,
                nameController.text,
                emailController.text,
                titleController.text,
                messageController.text,
              );
              Navigator.of(context).pop(); // Close the dialog after updating
            },
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.white), // White text color
            ),
          ),
        ],
      ),
    );
  }

  // Update feedback function
  void updateFeedback(
      String id, String name, String email, String title, String message) {
    FirebaseFirestore.instance.collection('feedbacks').doc(id).update({
      'fullName': name,
      'email': email,
      'title': title,
      'message': message,
    });
  }
}
