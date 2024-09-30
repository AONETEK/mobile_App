// import 'package:flutter/material.dart';

// class Tablewidget extends StatelessWidget {
//   final Map<String, dynamic> data;
//   Tablewidget({super.key, required this.data});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                       child: Text(
//                     'Ngày hóa đơn',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   )),
//                   Expanded(
//                       child: Text(
//                     'Số chứng từ',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   )),
//                   Expanded(
//                       child: Text(
//                     'Số hóa đơn',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   )),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(child: Text(data['postingDate'])),
//                   Expanded(child: Text(data['orderNumber'])),
//                   Expanded(child: Text(data['invoiceNo'])),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               buildDetailRow('Nhà cung cấp', data['suplier']),
//               buildDetailRow('Mô tả', data['description']),
//               buildDetailRow('Số tiền sau thuế', data['amount'].toString()),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// Widget buildDetailRow(String label, String value) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4.0),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 120,
//           child: Text(
//             '$label: ',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(color: Colors.black87),
//           ),
//         ),
//       ],
//     ),
//   );
// }

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
