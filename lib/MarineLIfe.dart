import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AnimalPage.dart';
import 'ExtinctAnimal.dart';
import 'Conservation.dart';
import 'Feedbacks.dart';

class MarineLifePage extends StatelessWidget {
  const MarineLifePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/BackgroundMarine.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'MARINE LIFE',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/oceanicCareLogo.png',
                      height: 240,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Explore the ocean\'s wonders and learn about fascinating marine life.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF07257C),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildButton('Animals', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AnimalPage()),
                      );
                    }),
                    const SizedBox(height: 10),
                    _buildButton('Extinct Animals', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ExtinctAnimal()),
                      );
                    }),
                    const SizedBox(height: 10),
                    _buildButton('Conservation Tips', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Conservation()),
                      );
                    }),
                    const SizedBox(height: 10),
                    _buildButton('Feedbacks', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Feedbacks()),
                      );
                    }),
                    const SizedBox(height: 10),
                    _buildOutlinedButton('Back', () {
                      Navigator.pop(context);
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 320,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A84D8),
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton(String text, VoidCallback onPressed) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 320,
        height: 50,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blue),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
