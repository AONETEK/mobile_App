import 'package:flutter/material.dart';

class ResponsiveCard extends StatelessWidget {
  final List<Map<String, String>> data;
  final List<String> columns;
  final int? expandedIndex;
  final ValueChanged<int?> onExpand;

  ResponsiveCard({
    required this.data,
    required this.columns,
    required this.expandedIndex,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final row = data[index];
        final isExpanded = expandedIndex == index;

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(row[columns[0]] ??
                    ''), // Assuming the first column is the title
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...columns
                        .sublist(1)
                        .map((col) => _buildDetailRow(col, row[col])),
                    if (isExpanded) ...[
                      _buildDetailRow(
                          'Additional Info', row['additionalDetails']),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      onExpand(isExpanded ? null : index);
                    },
                    child: Text(isExpanded ? 'Hide Details' : 'Show Details'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
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
}
