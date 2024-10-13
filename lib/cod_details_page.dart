import 'package:flutter/material.dart';

class CodDetailsPage extends StatelessWidget {
  const CodDetailsPage({Key? key}) : super(key: key);

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
                'Cod',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: Colors.black,
                  letterSpacing: 1.0,
                ),
              ),
              background: Image.asset(
                'assets/cod-cooked.jpg',
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
                      '(Peak: January - April)', Colors.blue),
                  const SizedBox(height: 16),
                  const Text(
                    'Cod Types',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 320,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCodTypeCard(
                          'Atlantic Cod',
                          'assets/atlantic_cod.webp',
                          'Good Alternative',
                          'North Atlantic',
                          'Longline',
                          Colors.orange,
                          'Fish and Chips',
                        ),
                        _buildCodTypeCard(
                          'Pacific Cod',
                          'assets/pacific_cod.webp',
                          'Best Choice',
                          'North Pacific',
                          'Trawl',
                          Colors.green,
                          'Cod Chowder',
                        ),
                        _buildCodTypeCard(
                          'Greenland Cod',
                          'assets/greenland_cod.webp',
                          'Good Alternative',
                          'Arctic',
                          'Gillnet',
                          Colors.orange,
                          'Boiled Cod',
                        ),
                        _buildCodTypeCard(
                          'Haddock',
                          'assets/haddock.webp',
                          'Best Choice',
                          'North Atlantic',
                          'Hook and Line',
                          Colors.green,
                          'Smoked Haddock',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Popular Cod Dishes',
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
                    'Cod is low in fat, high in protein, and an excellent source of vitamin B12, iodine, and selenium. It\'s also a good source of omega-3 fatty acids.',
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

  Widget _buildCodTypeCard(
      String name,
      String imagePath,
      String status,
      String country,
      String fishingMethod,
      Color statusColor,
      String popularDish) {
    return GestureDetector(
      onTap: () {
        // TODO: Add navigation to detailed cod type page
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
                          Text('Region: $country',
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
        'name': 'Fish and Chips',
        'country': 'UK',
        'image': 'assets/fish_and_chips.jpg'
      },
      {
        'name': 'Bacalao a la Vizcaina',
        'country': 'Spain',
        'image': 'assets/bacalao.jpg'
      },
      {
        'name': 'Cod Chowder',
        'country': 'USA',
        'image': 'assets/cod_chowder.jpg'
      },
      {
        'name': 'Cod Fish Cakes',
        'country': 'Portugal',
        'image': 'assets/cod_fish_cakes.jpg'
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
