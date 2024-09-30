import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onSearch;

  const ActionButtons(
      {required this.onAdd, required this.onRemove, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(icon: Icon(Icons.add), onPressed: onAdd),
            IconButton(icon: Icon(Icons.remove), onPressed: onRemove),
          ],
        ),
        ElevatedButton(
          onPressed: onSearch,
          child: Text('Tìm kiếm'),
        ),
      ],
    );
  }
}
