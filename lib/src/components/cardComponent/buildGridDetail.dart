import 'package:flutter/material.dart';

class BuildgridDetail extends StatelessWidget {
  final String label;
  final String value;
  const BuildgridDetail({
    required this.label,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
