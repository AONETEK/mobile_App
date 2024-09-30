import 'package:flutter/material.dart';

class DetailColumnWidget extends StatelessWidget {
  // Dữ liệu label tĩnh
  final List<String> labels;

  // Dữ liệu value động
  final List<dynamic> values;

  DetailColumnWidget({required this.values, required this.labels});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Grid layout cho các dòng chi tiết
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Ngăn cuộn của GridView
          crossAxisCount: 2, // Số cột trong lưới
          childAspectRatio: 3, // Tỷ lệ khung cho mỗi ô
          children: List.generate(labels.length, (index) {
            return buildGridDetail(labels[index], values[index]);
          }),
        ),
      ],
    );
  }

  // Hàm tạo widget chi tiết trong grid
  Widget buildGridDetail(String label, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4), // Khoảng cách giữa label và giá trị
        Text(
          value?.toString() ??
              'N/A', // Hiển thị giá trị hoặc 'N/A' nếu không có
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }
}
