import 'package:flutter/material.dart';

Widget buildDetailRow(String title, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            '$title:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value ?? '',
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    ),
  );
}
