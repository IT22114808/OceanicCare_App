import 'package:flutter/material.dart';

class ShrimpDetailsPage extends StatelessWidget {
  const ShrimpDetailsPage({Key? key}) : super(key: key);

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
                'Shrimp ',
                style: TextStyle(
                  fontWeight: FontWeight
                      .w600, // Semi-bold weight (adjust based on your fonts)
                  fontStyle: FontStyle
                      .normal, // Normal style (you can set italic or normal here)
                  fontSize: 20, // Adjust the font size as needed
                  color: Colors
                      .black, // Text color, here white for better visibility over image
                  letterSpacing: 1.0, // Optional: Adds spacing between letters
                ),
              ),
              background: Image.asset(
                'assets/shrimpscurry.jpg',
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
                  _buildInfoSection('Sustainability', 'High', Colors.green),
                  const SizedBox(height: 16),
                  _buildInfoSection('Local Availability',
                      'In Season (June - September)', Colors.blue),
                  const SizedBox(height: 16),
                  const Text(
                    'Shrimp Types',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 320,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildShrimpTypeCard(
                          'Atlantic Seabob',
                          'assets/red-shrimp.jpeg',
                          'Avoid',
                          'Mexico',
                          'Bottom trawls',
                          Colors.red,
                          'Camarones a la Diabla',
                        ),
                        _buildShrimpTypeCard(
                          'White Shrimp',
                          'assets/white-shrimp.png',
                          'Best Choice',
                          'USA',
                          'Farmed',
                          Colors.green,
                          'Shrimp and Grits',
                        ),
                        _buildShrimpTypeCard(
                          'Tiger Shrimp',
                          'assets/tiger-shrimp.webp',
                          'Good Alternative',
                          'Worldwide',
                          'Farmed',
                          Colors.orange,
                          'Gỏi Cuốn (Spring Rolls)',
                        ),
                        _buildShrimpTypeCard(
                          'Pink Shrimp',
                          'assets/pink-shrimp.jpeg',
                          'Best Choice',
                          'Oregon',
                          'Pot/Trap',
                          Colors.green,
                          'Oregon Pink Shrimp Cocktail',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Popular Shrimp Dishes',
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
                    'Shrimp is low in calories and high in protein. It\'s also a good source of selenium, vitamin B12, and omega-3 fatty acids.',
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

  Widget _buildShrimpTypeCard(
      String name,
      String imagePath,
      String status,
      String country,
      String fishingMethod,
      Color statusColor,
      String popularDish) {
    return GestureDetector(
      onTap: () {
        // TODO: Add navigation to detailed shrimp type page
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
        'name': 'Shrimp Scampi',
        'country': 'Italy',
        'image': 'assets/shrimp_scampi.jpg'
      },
      {
        'name': 'Pad Thai',
        'country': 'Thailand',
        'image': 'assets/pad_thai.jpg'
      },
      {
        'name': 'Ebi Tempura',
        'country': 'Japan',
        'image': 'assets/ebi_tempura.jpg'
      },
      {
        'name': 'Shrimp Po\' Boy',
        'country': 'USA',
        'image': 'assets/shrimp_po_boy.jpg'
      },
      {
        'name': 'Gambas al Ajillo',
        'country': 'Spain',
        'image': 'assets/gambas_al_ajillo.jpg'
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
