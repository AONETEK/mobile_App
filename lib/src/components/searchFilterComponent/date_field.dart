import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final TextEditingController fromController;
  final TextEditingController toController;

  const DateField({required this.fromController, required this.toController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: fromController,
            decoration: InputDecoration(
              labelText: 'Từ ngày',
              prefixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: toController,
            decoration: InputDecoration(
              labelText: 'Đến ngày',
              prefixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
