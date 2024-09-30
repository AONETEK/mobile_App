import 'package:flutter/material.dart';

class AdditionalFields extends StatelessWidget {
  final List<bool> isFieldExpanded;

  const AdditionalFields({required this.isFieldExpanded});

  @override
  Widget build(BuildContext context) {
    final additionalFields = ['Số chứng từ', 'Số hóa đơn'];
    return Column(
      children: List.generate(additionalFields.length, (index) {
        if (isFieldExpanded[index]) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: additionalFields[index],
                border: OutlineInputBorder(),
              ),
            ),
          );
        }
        return SizedBox.shrink();
      }),
    );
  }
}
