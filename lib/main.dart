import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:project_app/oceanic_care_home_page.dart';
import 'beach_cleanup_events.dart'; // Import the BeachCleanupEvents page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OceanicCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:
            GoogleFonts.poppinsTextTheme(), // Optional: add Google Fonts back
      ),
      home: const LaunchScreen(),
      //home: const OceanicCareHomePage(),
    );
  }
}

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToBeachCleanupEvents();
  }

  _navigateToBeachCleanupEvents() async {
    await Future.delayed(
        const Duration(seconds: 2)); // 2-second delay for splash effect
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BeachCleanupEventsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                // Add this back if needed
                // child: Image.asset(
                //   'assets/images/waves_top.png',
                //   width: double.infinity,
                //   fit: BoxFit.fitWidth,
                // ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/oceanic_care_logo.png', // Ensure image path is correct
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'OceanicCare',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Text(
                    'UNDERWATER',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                // Add this back if needed
                // child: Image.asset(
                //   'assets/images/waves_bottom.png',
                //   width: double.infinity,
                //   fit: BoxFit.fitWidth,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
