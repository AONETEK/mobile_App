import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Map<String, dynamic> row;

  const Header({required this.row});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              '${row['postingDate']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Flexible(
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
