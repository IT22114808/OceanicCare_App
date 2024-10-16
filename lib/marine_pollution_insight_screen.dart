import 'package:flutter/material.dart';
import 'pollutants_screen.dart';
import 'prevention_screen.dart';
import 'clean_ups_screen.dart';

class MarinePollutionInsightScreen extends StatelessWidget {
  const MarinePollutionInsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Marine Pollution Insight",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightBlue[100],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightBlue[50],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Marine Pollution is caused by a combination of chemicals and trash, most of which comes from land sources and is washed or blown into the ocean. It results in damage to the environment, health of organisms, and economic structures worldwide.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PollutantsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[200],
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Pollutants',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PreventionScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[200],
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Prevention Tips',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CleanUpsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[200],
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Clean ups',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/polution_turtle.jpg',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scan Me',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
        ],
        onTap: (index) {
          // Handle bottom navigation bar item taps here
        },
      ),
    );
  }
}
