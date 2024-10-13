import 'package:flutter/material.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final List<LocationCard> allLocations = [
    const LocationCard(
      location: 'Moratuwa',
      description: 'Angulana Beach',
      subDescription: 'Rotaract Club, University of Moratuwa',
      date: '30',
      month: 'Sep',
      participants: 60,
      imageUrl: 'assets/ocean1.jpg',
    ),
    const LocationCard(
      location: 'Mt. Lavinia',
      description: 'Rotaract Club, University of Moratuwa',
      date: '03',
      month: 'Oct',
      participants: 60,
      imageUrl: 'assets/ocean2.jpg',
    ),
    const LocationCard(
      location: 'Colombo',
      description: 'Galle Face Green',
      date: '15',
      month: 'Oct',
      participants: 75,
      imageUrl: 'assets/ocean3.jpg',
    ),
    const LocationCard(
      location: 'Negombo',
      description: 'Negombo Beach Park',
      date: '22',
      month: 'Oct',
      participants: 45,
      imageUrl: 'assets/ocean4.jpg',
    ),
    const LocationCard(
      location: 'Galle',
      description: 'Jungle Beach',
      date: '05',
      month: 'Nov',
      participants: 80,
      imageUrl: 'assets/ocean5.jpg',
    ),
    const LocationCard(
      location: 'Galle',
      description: 'Galle Fort',
      date: '12',
      month: 'Nov',
      participants: 55,
      imageUrl: 'assets/ocean1.jpg',
    ),
  ];

  List<LocationCard> filteredLocations = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredLocations = allLocations;
  }

  void filterLocations(String query) {
    setState(() {
      searchQuery = query;
      filteredLocations = allLocations
          .where((location) =>
              location.location.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // This line implements the back functionality
                    },
                  ),
                  const Text(
                    'Locations',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search locations',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: filterLocations,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLocations.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        filteredLocations[index],
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final String location;
  final String description;
  final String? subDescription;
  final String date;
  final String month;
  final int participants;
  final String imageUrl;

  const LocationCard({
    super.key,
    required this.location,
    required this.description,
    this.subDescription,
    required this.date,
    required this.month,
    required this.participants,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white),
                  ),
                  if (subDescription != null)
                    Text(
                      subDescription!,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$participants people participating',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            month,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
