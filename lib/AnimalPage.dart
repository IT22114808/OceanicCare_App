import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AboutAnimal.dart';

class AnimalPage extends StatelessWidget {
  const AnimalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFF1A84D8)),
                      iconSize: 28.0,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),

                  Text(
                    'Animals',
                    style: GoogleFonts.poppins(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 0),
            Center(
              // Center the GestureDetector within the page
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutAnimal()), // Replace with your destination page
                  );
                },

                child: Container(
                  height: 200,
                  width: 370,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.9), // Shadow color
                        spreadRadius: 2, // Spread of the shadow
                        blurRadius: 5, // Blur effect
                        offset: const Offset(0, 3), // Position of the shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        8), // Match the border radius of the container
                    child: Center(
                      // Center the image within the container
                      child: Image.asset(
                        'assets/ButterflyFish.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: Container(
                height: 200, // Set the height of the container
                width: 370, // Set the width of the container
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.9), // Shadow color
                      spreadRadius: 2, // Spread of the shadow
                      blurRadius: 5, // Blur effect
                      offset: const Offset(0, 3), // Changes the position of the shadow
                    ),
                  ],
                  borderRadius:
                      BorderRadius.circular(8), // Optional: for rounded corners
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      8), // Match the border radius of the container
                  child: Image.asset(
                    'assets/normalFish.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: Container(
                height: 200, // Set the height of the container
                width: 370, // Set the width of the container
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.9), // Shadow color
                      spreadRadius: 2, // Spread of the shadow
                      blurRadius: 5, // Blur effect
                      offset: const Offset(
                          0, 3), // Changes the position of the shadow
                    ),
                  ],
                  borderRadius:
                      BorderRadius.circular(8), // Optional: for rounded corners
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      8), // Match the border radius of the container
                  child: Image.asset(
                    'assets/goldFish.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
          ], 
        ),
      ),
    );
  }
}//flutter clean
//flutter pub get
