import 'package:flutter/material.dart';

class ResponsiveDataTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final List<String> columns;
  final int? expandedIndex;
  final ValueChanged<int?> onExpand;

  ResponsiveDataTable({
    required this.data,
    required this.columns,
    required this.expandedIndex,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data.asMap().entries.map(
        (entry) {
          final index = entry.key;
          final row = entry.value;
          final isExpanded = expandedIndex == index;

          return Column(
            children: [
              DataTable(
                columns:
                    columns.map((col) => DataColumn(label: Text(col))).toList()
                      ..add(
                        DataColumn(label: Text('Actions')),
                      ),
                rows: [
                  DataRow(
                    cells: columns.map((col) {
                      final cellValue = row[col]?.toString() ?? '';
                      return DataCell(Text(cellValue));
                    }).toList()
                      ..add(
                        DataCell(
                          TextButton(
                            onPressed: () {
                              onExpand(isExpanded ? null : index);
                            },
                            child: Text(
                                isExpanded ? 'Hide Details' : 'Show Details'),
                          ),
                        ),
                      ),
                  ),
                  if (isExpanded) ...[
                    DataRow(
                      cells: columns.map((col) {
                        final cellValue = row[col]?.toString() ?? '';
                        return DataCell(Text(cellValue));
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
