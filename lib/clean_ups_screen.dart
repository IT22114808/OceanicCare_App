import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart'; // Add this import for date formatting

class CleanUpsScreen extends StatelessWidget {
  const CleanUpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marine Pollution Insight'),
        backgroundColor: Colors.lightBlue[100],
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Clean Ups',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Ocean pollution clean-ups are vital efforts aimed at removing waste and debris from marine environments, especially beaches, coasts, and coastal areas. These clean-ups typically focus on collecting plastic waste, fishing gear, and other harmful pollutants that pose threats to marine life.',
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1),
                  },
                  border: TableBorder.all(color: Colors.grey[300]!),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.lightBlue[50]),
                      children: [
                        _buildTableHeader('Date'),
                        _buildTableHeader('Location'),
                        _buildTableHeader('Time'),
                      ],
                    ),
                    _buildTableRow(DateTime(2024, 10, 15), 'Beach City', '9:00 AM'),
                    _buildTableRow(DateTime(2024, 10, 22), 'Coral Bay', '10:00 AM'),
                    _buildTableRow(DateTime(2024, 10, 29), 'Harbor Point', '8:30 AM'),
                    _buildTableRow(DateTime(2024, 11, 5), 'Lagoon Park', '9:30 AM'),
                    _buildTableRow(DateTime(2024, 11, 12), 'Seaside Cove', '10:30 AM'),
                    _buildTableRow(DateTime(2024, 12, 6), 'Hikkaduwa Beach', '11:30 AM'),
                    _buildTableRow(DateTime(2025, 1, 24), 'Tutle Beach', '8:30 AM'),

                  ],
                ),
              ),
            ),
          ),
        ],
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
        onTap: (index) {
          // Handle bottom navigation bar item taps here
        },
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildTableRow(DateTime date, String location, String time) {
    final dateFormat = DateFormat('MMM d, yyyy');
    return TableRow(
      children: [
        _buildTableCell(dateFormat.format(date)),
        _buildTableCell(location),
        _buildTableCell(time),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
