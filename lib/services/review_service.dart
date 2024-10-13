import 'dart:convert';
import 'package:http/http.dart' as http;

class ReviewService {
  static const String baseUrl = 'http://10.0.2.2:5000';

  Future<bool> submitReview({
    required String name,
    required String username,
    required int rating,
    required String comment,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Review/addReview'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'username': username,
          'rating': rating,
          'comment': comment,
        }),
      );

      if (response.statusCode == 201) {
        print('Review submitted successfully');
        return true;
      } else {
        print(
            'Error submitting review: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception while submitting review: $e');
      return false;
    }
  }
  Future<List<Review>> getReviews(String name) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Review/getReview/$name'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((review) => Review.fromJson(review)).toList();
      } else if (response.statusCode == 404) {
        print('No reviews found for $name');
        return [];
      } else {
        print('Error fetching reviews: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception while fetching reviews: $e');
      return [];
    }
  }

  Future<bool> deleteReview(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/Review/deleteReview/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Review deleted successfully');
        return true;
      } else if (response.statusCode == 404) {
        print('Review not found');
        return false;
      } else {
        print('Error deleting review: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception while deleting review: $e');
      return false;
    }
  }
}

class Review {
  final String id;
  final String name;
  final String username;
  final int rating;
  final String comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.name,
    required this.username,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      name: json['name'],
      username: json['username'] ?? 'Anonymous',
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
