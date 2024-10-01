import 'package:flutter/material.dart';
import 'buildGridDetail.dart';
import 'header.dart';

class BuildCard extends StatelessWidget {
  final Map<String, dynamic> row;
  final List<String> listLabel;
  final List<String> listRow;

  const BuildCard(
      {required this.row, required this.listLabel, required this.listRow});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(row: row),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    children: [
                      BuildgridDetail(
                          label: listLabel[0], value: row[listRow[0]]),
                      BuildgridDetail(
                          label: listLabel[1], value: row[listRow[1]]),
                      BuildgridDetail(
                          label: listLabel[2], value: row[listRow[2]]),
                      BuildgridDetail(
                          label: listLabel[3], value: row[listRow[3]]),
                      BuildgridDetail(
                          label: listLabel[4], value: row[listRow[4]]),
                      BuildgridDetail(
                          label: listLabel[5],
                          value: row[listRow[5]].toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
