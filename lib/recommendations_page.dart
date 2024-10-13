import 'package:flutter/material.dart';
import 'review_page.dart';
import '../services/review_service.dart';

class RecommendationsPage extends StatefulWidget {
  const RecommendationsPage({Key? key}) : super(key: key);

  @override
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<SeafoodRecommendation> _recommendations = [];
  String _currentMapImage = 'assets/map.png';
  bool _isLoading = false;
  final ReviewService _reviewService = ReviewService();

  Future<void> _searchSeafood(String location) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate network delay
      await Future.delayed(Duration(seconds: 2));

      // Update map image based on location
      setState(() {
        switch (location.toLowerCase()) {
          case 'hikkaduwa':
            _currentMapImage = 'assets/Hikkaduwa.png';
            _recommendations = [
              SeafoodRecommendation(
                name: 'Fresh Tuna',
                description: 'Local yellow-fin tuna, perfect for sashimi',
                location: location,
                imagePath: 'assets/tuna-cooked.jpg',
              ),
              SeafoodRecommendation(
                name: 'Grilled Prawns',
                description: 'Giant tiger prawns with local spices',
                location: location,
                imagePath: 'assets/shrimp_scampi.jpg',
              ),
              SeafoodRecommendation(
                name: 'Coral Reef Fish',
                description:
                    'Fresh catch from coral reefs, grilled to perfection',
                location: location,
                imagePath: 'assets/reef-fish-cooked.jpg',
              ),
            ];
            break;

          case 'colombo':
            _currentMapImage = 'assets/Colombo.png';
            _recommendations = [
              SeafoodRecommendation(
                name: 'Butter Fish',
                description: 'Soft and buttery white fish in curry sauce',
                location: location,
                imagePath: 'assets/butter-fish-cooked.jpg',
              ),
              SeafoodRecommendation(
                name: 'Lagoon Crab',
                description: 'Fresh mud crabs from Negombo lagoon',
                location: location,
                imagePath: 'assets/crab-cooked.jpg',
              ),
              SeafoodRecommendation(
                name: 'Cuttle Fish',
                description: 'Spicy devilled cuttle fish',
                location: location,
                imagePath: 'assets/cuttle-fish-cooked.jpg',
              ),
            ];
            break;

          case 'trincomalee':
            _currentMapImage = 'assets/Trinco.png';
            _recommendations = [
              SeafoodRecommendation(
                name: 'Fresh Salmon',
                description: 'Locally sourced wild-caught salmon',
                location: location,
                imagePath: 'assets/salmon-cooked.jpg',
              ),
              SeafoodRecommendation(
                name: 'Grilled Cod',
                description: 'Flaky white cod with herbs',
                location: location,
                imagePath: 'assets/cod-cooked.jpg',
              ),
              SeafoodRecommendation(
                name: 'King Crab Legs',
                description: 'Succulent Alaskan king crab',
                location: location,
                imagePath: 'assets/crab-cooked.jpg',
              ),
            ];
            break;
          default:
            _currentMapImage = 'assets/map.png';
            _recommendations = [];
        }
        _isLoading = false;
      });

      for (var recommendation in _recommendations) {
        final reviews = await _reviewService.getReviews(recommendation.name);
        setState(() {
          recommendation.reviews = reviews;
        });
      }
    } catch (e) {
      print("Error searching location: $e");
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error searching for location. Please try again.')),
      );
    }
  }

  Future<void> _deleteReview(
      SeafoodRecommendation recommendation, Review review) async {
    try {
      bool success = await _reviewService.deleteReview(review.id);
      if (success) {
        setState(() {
          recommendation.reviews.remove(review);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete review')),
        );
      }
    } catch (e) {
      print("Error deleting review: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error deleting review. Please try again.')),
      );
    }
  }

  Widget _buildReviewCard(SeafoodRecommendation recommendation, Review review) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.blue[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            left: 12,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue[300],
              child: Text(
                review.username[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.white, size: 14),
                  const SizedBox(width: 2),
                  Text(
                    review.rating.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  review.comment,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[800],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteReview(recommendation, review),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(SeafoodRecommendation recommendation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              recommendation.imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recommendation.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  recommendation.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Location: ${recommendation.location}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                if (recommendation.reviews.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reviews',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                            Text(
                              '${recommendation.reviews.length} reviews',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 150, // Fixed height for scrollable area
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recommendation.reviews.length,
                          itemBuilder: (context, index) {
                            final review = recommendation.reviews[index];
                            return _buildReviewCard(recommendation, review);
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Implement action to view all reviews
                          },
                          icon: const Icon(Icons.rate_review, size: 16),
                          label: const Text('View All Reviews',
                              style: TextStyle(fontSize: 14)),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReviewPage(
                          recommendation: recommendation,
                        ),
                      ));
                    },
                    icon: const Icon(Icons.rate_review, size: 18),
                    label: const Text('Add Review'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map image background
          Image.asset(
            _currentMapImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Column(
              children: [
                // Search bar and location
                // Improved back button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.blue, size: 28),
                        onPressed: () {
                          Navigator.of(context).pop(); // Navigate back
                        },
                      ),
                    ),
                  ),
                ),
                // Search bar and location
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.blue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search for location',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) => _searchSeafood(value),
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.my_location, color: Colors.blue),
                          onPressed: () {
                            // Implement location detection logic
                            _searchSeafood("Current Location");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // Recommended section
                Expanded(
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    minChildSize: 0.2,
                    maxChildSize: 0.8,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ListView(
                                controller: scrollController,
                                padding: const EdgeInsets.all(16),
                                children: [
                                  Center(
                                    child: Container(
                                      width: 40,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.blue.shade200,
                                          width: 1),
                                    ),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: _recommendations.isEmpty
                                                ? 'Search for seafood recommendations'
                                                : 'Most Popular Seafood for ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade800,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          if (!_recommendations.isEmpty)
                                            TextSpan(
                                              text: _searchController.text,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange
                                                    .shade800, // Different color for search text
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ..._recommendations
                                      .map(_buildRecommendationCard)
                                      .toList(),
                                ],
                              ),
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
}

class SeafoodRecommendation {
  final String name;
  final String description;
  final String location;
  final String imagePath;
  List<Review> reviews;

  SeafoodRecommendation({
    required this.name,
    required this.description,
    required this.location,
    required this.imagePath,
    this.reviews = const [],
  });
  SeafoodRecommendation copyWith({Review? review}) {
    return SeafoodRecommendation(
      name: this.name,
      description: this.description,
      location: this.location,
      imagePath: this.imagePath,
      reviews: reviews ?? this.reviews,
    );
  }
}
