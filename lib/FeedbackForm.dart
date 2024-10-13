import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Firestore
import 'services/database.dart'; // Adjust the import according to your project structure
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:fluttertoast/fluttertoast.dart'; // Import for Toast messages

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  final DatabaseMethods _databaseMethods = DatabaseMethods();
  bool _isSubmitting = false;

  // Helper function to show toast messages
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Validation for email format
  bool _validateEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  // Validation for phone number
  bool _validatePhone(String phone) {
    // Assuming valid phone numbers should be 10 digits
    String phonePattern = r'^[0-9]{10}$';
    RegExp regExp = RegExp(phonePattern);
    return regExp.hasMatch(phone);
  }

  void _submitFeedback() async {
    // Validating fields
    if (_nameController.text.isEmpty) {
      _showToast('Please enter your full name');
      return;
    }

    if (_phoneController.text.isEmpty || !_validatePhone(_phoneController.text)) {
      _showToast('Please enter a valid 10-digit phone number');
      return;
    }

    if (_emailController.text.isEmpty || !_validateEmail(_emailController.text)) {
      _showToast('Please enter a valid email address');
      return;
    }

    if (_titleController.text.isEmpty) {
      _showToast('Please enter the title of your feedback');
      return;
    }

    if (_feedbackController.text.isEmpty) {
      _showToast('Please enter your feedback message');
      return;
    }

    setState(() {
      _isSubmitting = true; // Show loading state
    });

    // Create a feedback info map
    Map<String, dynamic> feedbackInfoMap = {
      'fullName': _nameController.text,
      'phoneNumber': _phoneController.text,
      'email': _emailController.text,
      'title': _titleController.text,
      'message': _feedbackController.text,
      'timestamp': FieldValue.serverTimestamp(), // Use Firestore timestamp
    };

    // Await the result of the addFeedback method
    bool success = await _databaseMethods.addFeedback(feedbackInfoMap);

    setState(() {
      _isSubmitting = false; // Hide loading state
    });

    if (success) {
      _showToast('Feedback submitted successfully!');
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _titleController.clear();
      _feedbackController.clear(); // Clear all input fields
    } else {
      _showToast('Failed to submit feedback. Please try again.');
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    // Show a confirmation dialog here if needed
    _submitFeedback(); // Call the submit feedback function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0), // Set the desired height
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF1A84D8)),
                  iconSize: 28.0,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Text(
                'Add your Feedback',
                style: GoogleFonts.poppins(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue focused border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue enabled border
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue focused border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue enabled border
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue focused border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue enabled border
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue focused border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue enabled border
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                labelText: 'Enter your feedback',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue focused border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: const BorderSide(color: Colors.blue), // Blue enabled border
                ),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16.0),
            _isSubmitting
                ? const CircularProgressIndicator() // Show loading indicator
                : const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 320,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A84D8), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // Rounded button
                    ),
                  ),
                  onPressed: () => _showConfirmationDialog(context),
                  child: Text(
                    'Submit',
                    style: GoogleFonts.poppins(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.w700, // Font weight
                      fontSize: 16, // Font size
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 320,
                height: 45,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // Rounded button
                    ),
                    side: const BorderSide(color: const Color(0xFF1A84D8)), // Outline color
                  ),
                  onPressed: () {
                    // Clear all fields
                    _nameController.clear();
                    _phoneController.clear();
                    _emailController.clear();
                    _titleController.clear();
                    _feedbackController.clear();
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF1A84D8), // Text color
                      fontWeight: FontWeight.w700, // Font weight
                      fontSize: 16, // Font size
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
