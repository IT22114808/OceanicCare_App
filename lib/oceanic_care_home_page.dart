import 'package:flutter/material.dart';
import 'MarineLife.dart';
import 'upcoming_events.dart';
import 'home.dart';
import 'marine_pollution_insight_screen.dart';

class OceanicCareHomePage extends StatelessWidget {
  const OceanicCareHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OceanicCare',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShareThoughtsCard(),
              const SizedBox(height: 16),
              _buildEventCarousel(context),
              const SizedBox(height: 16),
              const Text(
                'Expand your horizons',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildDolphinCard(context),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildSmallCard(
                      context,
                      'Sustainable seafoods',
                      'assets/images/seafood.png',
                      isSeafoodCard: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSmallCard(
                      context,
                      'Pollution insights',
                      'assets/images/pollution.png',
                      isSeafoodCard: false, // Pollution Insights card
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareThoughtsCard() {
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Expanded(
              child: Text('Share your thoughts',
                  style: TextStyle(color: Colors.grey)),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCarousel(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/event_image_$index.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Join events and\nbecome a warrior',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UpcomingEventsPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                          ),
                          child: const Text("I'm Interested"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDolphinCard(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MarineLifePage()),
              );
            },
            child: Image.asset(
              'assets/images/dolphin.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Learn about unknown things\nabout dolphins',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MarineLifePage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCard(BuildContext context, String title, String imagePath,
      {required bool isSeafoodCard}) {
    return GestureDetector(
      onTap: () {
        if (isSeafoodCard) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        } else {
          // Navigate to the marine pollution insight screen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MarinePollutionInsightScreen()),
          );
        }
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath,
                height: 100, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
