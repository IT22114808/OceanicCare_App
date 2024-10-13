import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Conservation extends StatelessWidget {
  const Conservation({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> tips = [
      {
        'title': 'Reduce Plastic Use:',
        'description':
            'Avoid single-use plastics like straws, bags, and bottles to prevent ocean pollution.',
      },
      {
        'title': 'Conserve Water:',
        'description':
            'Use water wisely to reduce runoff, which can carry pollutants to the ocean.',
      },
      {
        'title': 'Support Sustainable Seafood:',
        'description':
            'Choose seafood that is caught or farmed in ways that protect marine life and habitats.',
      },
      {
        'title': 'Participate in Beach Cleanups:',
        'description':
            'Join local efforts to clean up beaches and waterways to reduce trash in the ocean.',
      },
      {
        'title': 'Use Eco-friendly Products:',
        'description':
            'Opt for products that are biodegradable and free of harmful chemicals to protect marine ecosystems.',
      },
      {
        'title': 'Support Marine Protected Areas:',
        'description':
            'Advocate for creating reserves to protect habitats and biodiversity.',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.blue[800]),
                      iconSize: 24.0,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Text(
                    'Conservation Tips',
                    style: GoogleFonts.poppins(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tips.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tips[index]['title']!,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tips[index]['description']!,
                            style: GoogleFonts.poppins(color: Colors.blue[800]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 320,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue[800]!),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Back',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
