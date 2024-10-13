import 'package:flutter/material.dart';

class CrabDetailsPage extends StatelessWidget {
  const CrabDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Crab',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: Colors.black,
                  letterSpacing: 1.0,
                ),
              ),
              background: Image.asset(
                'assets/crab-cooked.jpg',
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection(
                      'Sustainability', 'Moderate', Colors.orange),
                  const SizedBox(height: 16),
                  _buildInfoSection('Local Availability',
                      'In Season(May - November)', Colors.blue),
                  const SizedBox(height: 16),
                  const Text(
                    'Crab Types',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 320,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCrabTypeCard(
                          'Dungeness Crab',
                          'assets/dungeness_crab.webp',
                          'Best Choice',
                          'USA',
                          'Trap',
                          Colors.green,
                          'Crab Cakes',
                        ),
                        _buildCrabTypeCard(
                          'Blue Crab',
                          'assets/blue-crab.webp',
                          'Good Alternative',
                          'USA',
                          'Trap',
                          Colors.orange,
                          'Maryland Crab Soup',
                        ),
                        _buildCrabTypeCard(
                          'King Crab',
                          'assets/king_crab.webp',
                          'Good Alternative',
                          'Alaska',
                          'Pot',
                          Colors.orange,
                          'Steamed King Crab Legs',
                        ),
                        _buildCrabTypeCard(
                          'Snow Crab',
                          'assets/snow-crab.webp',
                          'Best Choice',
                          'Canada',
                          'Trap',
                          Colors.green,
                          'Snow Crab Cluster',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Popular Crab Dishes',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildPopularDishes(),
                  const SizedBox(height: 16),
                  const Text(
                    'Nutritional Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Crab is low in fat and calories, high in protein, and rich in vitamins and minerals including vitamin B12, zinc, and selenium.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Home'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(value,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildCrabTypeCard(
      String name,
      String imagePath,
      String status,
      String country,
      String fishingMethod,
      Color statusColor,
      String popularDish) {
    return GestureDetector(
      onTap: () {
        // TODO: Add navigation to detailed crab type page
        print('Tapped on $name');
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(color: statusColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0, 6),
              blurRadius: 8,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.grey.shade100,
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    imagePath,
                    height: 150,
                    width: 220,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      width: 220,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            status,
                            style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text('Country: $country',
                              style: const TextStyle(fontSize: 14)),
                          Text('Fishing: $fishingMethod',
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 4),
                          Text('Popular Dish: $popularDish',
                              style: const TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularDishes() {
    final dishes = [
      {
        'name': 'Crab Cakes',
        'country': 'USA',
        'image': 'assets/crab_cakes.jpg'
      },
      {
        'name': 'Singapore Chili Crab',
        'country': 'Singapore',
        'image': 'assets/chili_crab.jpg'
      },
      {
        'name': 'Crab Bisque',
        'country': 'France',
        'image': 'assets/crab_bisque.jpg'
      },
    ];

    return Column(
      children: dishes
          .map((dish) => Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 100,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Image.asset(
                          dish['image']!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dish['name']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Origin: ${dish['country']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
