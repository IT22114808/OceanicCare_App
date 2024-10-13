import 'package:flutter/material.dart';

class TopContributorsScreen extends StatelessWidget {
  const TopContributorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Top contributors',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Participate in the events organized by OceanicCare app and become a superstar.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const TopContributorCard(
                  name: 'Rosie Montgomery',
                  events: 16,
                  imageUrl: 'assets/girl.png',
                ),
                const SizedBox(height: 16),
                ...List.generate(
                  6,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ContributorListItem(
                      position: index + 2,
                      name: [
                        'Ann Frank',
                        'David Jones',
                        'Mark Wood',
                        'Alyse Perry',
                        'Peter Parker',
                        'Lara Croft'
                      ][index],
                      events: [12, 10, 9, 8, 6, 4][index],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      
    );
  }
}

class TopContributorCard extends StatelessWidget {
  final String name;
  final int events;
  final String imageUrl;

  const TopContributorCard({
    super.key,
    required this.name,
    required this.events,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(16)),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Events',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      events.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContributorListItem extends StatelessWidget {
  final int position;
  final String name;
  final int events;

  const ContributorListItem({
    super.key,
    required this.position,
    required this.name,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            '#$position',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Text(
            events.toString().padLeft(2, '0'),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
