import 'package:flutter/material.dart';

class PreventionScreen extends StatelessWidget {
  const PreventionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Marine Pollution Insight",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightBlue[100],
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tips',
                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Here are some ocean pollution tips to help reduce your impact and protect marine environments:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      BulletPoint(
                        'Reduce Single-Use Plastics:',
                        'Opt for reusable bags, bottles, and containers to responsibly dispose items that affect our marine life.',
                      ),
                      BulletPoint(
                        'Participate in Beach Cleanups:',
                        'Join local clean-up events to organize your own to help remove trash from beaches before it enters the ocean.',
                      ),
                      BulletPoint(
                        'Proper Disposal of Waste:',
                        'Never dump hazardous materials, paints, and chemicals in drains or oceans. Take them to designated waste disposal centers.',
                      ),
                      BulletPoint(
                        'Use Eco-friendly Products:',
                        'Switch to biodegradable and non-toxic cleaning products to reduce harmful chemicals entering our recycling ecosystem.',
                      ),
                      BulletPoint(
                        'Conserve Water:',
                        'Reduce your water consumption to minimize runoff and pollution, which can carry contaminants into the ocean.',
                      ),
                      BulletPoint(
                        'Support Conservation:',
                        'Choose sustainably sourced seafood to reduce overfishing and protect marine ecosystems.',
                      ),
                    ],
                  ),
                ),
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
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String title;
  final String description;

  const BulletPoint(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: '$title ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}