import 'package:flutter/material.dart';

class FinancialCard extends StatelessWidget {
  final String title;
  final String year;
  // final String image;
  final Color color;

  const FinancialCard({
    required this.title,
    required this.year,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon(icon, size: 20, color: color),
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  // Padding(padding: 20),
                  Text(
                    title,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
