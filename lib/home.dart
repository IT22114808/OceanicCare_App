import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'shrimp_details_page.dart';
import 'recommendations_page.dart';
import 'crab_details_page.dart';
import 'cod_details_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCategory = '';
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final Map<DateTime, List<Map<String, dynamic>>> _seasonalSeafood = {
    DateTime(2024, 10, 1): [
      {'name': 'Cod', 'image': 'assets/cod.png', 'height': 40.0},
      {'name': 'Crab', 'image': 'assets/crab.png', 'height': 40.0},
      {'name': 'Trout', 'image': 'assets/Trout.png', 'height': 40.0},
      {'name': 'Shirmp', 'image': 'assets/white-shrimp.png', 'height': 40.0},
    ],
    DateTime(2024, 11, 1): [
      {'name': 'Salmon', 'image': 'assets/salmon.png'},
      {'name': 'Lobster', 'image': 'assets/Lobster.png'},
      {'name': 'Tilapia', 'image': 'assets/Tilapia.png'}
    ],
  };

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      searchQuery = '';
      searchController.clear();
    });
  }

  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<Map<String, dynamic>> _getSeafoodForDay(DateTime day) {
    return _seasonalSeafood[DateTime(day.year, day.month, 1)] ?? [];
  }

  Widget _buildCalendarDayCell(
      BuildContext context, DateTime day, DateTime focusedDay) {
    List<Map<String, dynamic>> seafoodItems = _getSeafoodForDay(day);
    bool isSelected = isSameDay(_selectedDay, day);

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(8),
        border: isSelected ? Border.all(color: Colors.blue, width: 1) : null,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${day.day}',
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
          if (seafoodItems.isNotEmpty)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double customSizeMultiplier =
                        0.25; // Customize this value to adjust size
                    double imageSize = constraints.maxWidth *
                        customSizeMultiplier; // Apply multiplier for sizing

                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8, // Adjust space between images
                      runSpacing: 8, // Adjust space between rows
                      children: seafoodItems.map((item) {
                        return Container(
                          width: imageSize, // Use customized image size
                          height: imageSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(item['image']!),
                              fit: BoxFit
                                  .cover, // Ensures the image covers the circle
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSeafoodGrid(List<Map<String, dynamic>> seafoodItems) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.75,
      ),
      itemCount: seafoodItems.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blueGrey.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: Colors.blueGrey.withOpacity(0.2), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                spreadRadius: -2,
                blurRadius: 6,
                offset: Offset(0, -3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  seafoodItems[index]['image']!,
                  height: seafoodItems[index]['height'],
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                seafoodItems[index]['name']!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget displaySelectedCategory() {
    if (selectedCategory == 'Type') {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search seafood...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          _buildRowTitle("Shellfish"),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _getFilteredItems([
                _buildImageContainer('assets/crab.png', 'Crab', 120),
                _buildImageContainer('assets/Lobster.png', 'Lobster', 100),
                _buildImageContainer(
                    'assets/white-shrimp.png', 'White Shrimp', 100),
                _buildImageContainer(
                    'assets/softshell-clam.png', 'Softshell Clam', 100),
                _buildImageContainer(
                    'assets/farmed-oyster.png', 'Farmed Oyster', 90),
              ]),
            ),
          ),
          const SizedBox(height: 20),
          _buildRowTitle("fish"),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _getFilteredItems([
                _buildImageContainer('assets/cod.png', 'Cod', 50),
                _buildImageContainer('assets/Halibut.png', 'Halibut', 75),
                _buildImageContainer('assets/Herring.png', 'Herring', 40),
                _buildImageContainer('assets/Mackerel.png', 'Mackerel', 40),
                _buildImageContainer('assets/salmon.png', 'Salmon', 40),
              ]),
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _getFilteredItems([
                _buildImageContainer('assets/Sardine.png', 'Sardine', 50),
                _buildImageContainer('assets/Snapper.png', 'Snapper', 75),
                _buildImageContainer('assets/Trout.png', 'Trout', 40),
                _buildImageContainer('assets/tuna.png', 'Tuna', 55),
                _buildImageContainer('assets/Tilapia.png', 'Tilapia', 90),
              ]),
            ),
          ),
        ],
      );
    } else if (selectedCategory == 'Sustainability') {
      return Column(
        children: [
          _buildSustainabilityCard('Sardine', 'Sardine.png', 5, Colors.green),
          const SizedBox(height: 20),
          _buildSustainabilityCard('Herring', 'Herring.png', 3, Colors.green),
          const SizedBox(height: 20),
          _buildSustainabilityCard('Snapper', 'Snapper.png', 1, Colors.red),
        ],
      );
    } else if (selectedCategory == 'Season') {
      return Column(
        // Add 'return' here
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: _buildCalendarDayCell,
              selectedBuilder: _buildCalendarDayCell,
              todayBuilder: _buildCalendarDayCell,
            ),
          ),
          const SizedBox(height: 10),
          if (_selectedDay != null) ...[
            Text(
              'Highly Available Seafoods on ${_selectedDay!.toString().split(' ')[0]}:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSeafoodGrid(_getSeafoodForDay(_selectedDay!)),
          ],
        ],
      );
    } else {
      return const Text(
        'Please select a category',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      );
    }
  }

  List<Widget> _getFilteredItems(List<Widget> items) {
    if (searchQuery.isEmpty) {
      return items;
    } else {
      return items.where((item) {
        if (item is GestureDetector) {
          final Container container = item.child as Container;
          final Column column = container.child as Column;
          final Widget nameWidget = column.children.lastWhere(
            (child) => child is Text,
            orElse: () => const SizedBox(),
          );
          if (nameWidget is Text) {
            final String name = nameWidget.data ?? '';
            return name.toLowerCase().contains(searchQuery.toLowerCase());
          }
        }
        return false;
      }).toList();
    }
  }

  Widget _buildRowTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildImageContainer(String imagePath, String name, double height) {
    return GestureDetector(
      onTap: () {
        Widget? detailsPage;
        switch (name) {
          case 'White Shrimp':
            detailsPage = const ShrimpDetailsPage();
            break;
          case 'Crab':
            detailsPage = const CrabDetailsPage();
            break;
          case 'Cod':
            detailsPage = const CodDetailsPage();
            break;
        }

        if (detailsPage != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => detailsPage!),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 180,
        width: 150,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: height,
                width: 150,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSustainabilityCard(
      String name, String imagePath, int rating, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border(
          left: BorderSide(color: borderColor, width: 10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image Section
          Image.asset(
            'assets/$imagePath', // Adds 'assets/' to the image path passed.
            width: 280,
            height: 80,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              );
            },
          ),
          const SizedBox(height: 10),

          // Name Section
          Text(
            name,
            style: const TextStyle(
              fontSize: 20, // Increased font size for emphasis
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2, // Adds spacing between letters for style
            ),
          ),
          const SizedBox(height: 5),

          // Sustainability Rating Label
          Text(
            'Sustainability Rating:', // Added rating label
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700], // Soft color for label
            ),
          ),
          const SizedBox(height: 5),

          // Rating Stars Section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds);
                },
                child: Icon(
                  index < rating
                      ? Icons.star
                      : Icons.star_border, // Outlined for unselected stars
                  color: index < rating ? Colors.blueAccent : Colors.grey,
                  size: 24, // Increased star size for more emphasis
                ),
              ),
            ),
          ),
          const SizedBox(height: 10), // Add extra space for better layout
        ],
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Navigate back to the previous screen (main.dart)
                      },
                    ),
                    const Expanded(
                      child: Text(
                        "Seafood Guide",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // To balance the layout
                  ],
                ),
                const SizedBox(height: 10),
                // Rest of your existing conten
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hello, Nipun",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Row(
                      children: [
                        // Recommendations Button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RecommendationsPage(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  'Recommendations',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  "Discover and Get great food,",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCategoryButton('Type', Icons.fastfood, Colors.blue),
                    _buildCategoryButton(
                        'Sustainability', Icons.eco, Colors.green),
                    _buildCategoryButton(
                        'Season', Icons.calendar_today, Colors.orange),
                  ],
                ),
                const SizedBox(height: 30),
                displaySelectedCategory(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String label, IconData icon, Color color) {
    bool isSelected = selectedCategory == label;

    return ElevatedButton.icon(
      onPressed: () {
        selectCategory(label);
      },
      icon: Icon(
        icon,
        color: isSelected ? Colors.white : color,
        size: 12,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 12,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: isSelected ? color : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
          color: color,
          width: 1.5,
        ),
      ),
    );
  }
}
