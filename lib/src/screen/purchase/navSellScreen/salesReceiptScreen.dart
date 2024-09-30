import 'package:flutter/material.dart';
//
import '../../../Widget/detailsRow.dart';

class SalesReceiptScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SalesReceiptScreen> {
  int? selectedIndex;
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        "postingDate": "06/08/2024",
        "orderNumber": "MH24-000578",
        "invoiceNo": "00002495",
        "customer": "CÔNG TY TNHH THÉP ĐẶC BIỆT LÊ PHÚC",
        "description":
            "Mua hàng từ nhà cung cấp CÔNG TY TNHH THÉP ĐẶC BIỆT LÊ PHÚC theo hoá đơn số 00002495",
        "amount": 7847280
      },
      {
        "postingDate": "07/08/2024",
        "orderNumber": "MH24-000579",
        "invoiceNo": "00002496",
        "customer": "CÔNG TY CỔ PHẦN XÂY DỰNG PHÚ THỊNH",
        "description":
            "Mua hàng từ nhà cung cấp CÔNG TY CỔ PHẦN XÂY DỰNG PHÚ THỊNH theo hoá đơn số 00002496",
        "amount": 12500000
      },
      {
        "postingDate": "08/08/2024",
        "orderNumber": "MH24-000580",
        "invoiceNo": "00002497",
        "customer": "CÔNG TY TNHH NỘI THẤT VIỆT PHÁT",
        "description":
            "Mua hàng từ nhà cung cấp CÔNG TY TNHH NỘI THẤT VIỆT PHÁT theo hoá đơn số 00002497",
        "amount": 9320000
      },
      {
        "postingDate": "09/08/2024",
        "orderNumber": "MH24-000581",
        "invoiceNo": "00002498",
        "customer": "CÔNG TY TNHH XÂY DỰNG ĐÔNG Á",
        "description":
            "Mua hàng từ nhà cung cấp CÔNG TY TNHH XÂY DỰNG ĐÔNG Á theo hoá đơn số 00002498",
        "amount": 15250000
      },
      {
        "postingDate": "10/08/2024",
        "orderNumber": "MH24-000582",
        "invoiceNo": "00002499",
        "customer": "CÔNG TY TNHH VẬT LIỆU XÂY DỰNG THÁI BÌNH",
        "description":
            "Mua hàng từ nhà cung cấp CÔNG TY TNHH VẬT LIỆU XÂY DỰNG THÁI BÌNH theo hoá đơn số 00002499",
        "amount": 6750000
      },
      {
        "postingDate": "11/08/2024",
        "orderNumber": "MH24-000583",
        "invoiceNo": "00002500",
        "customer": "CÔNG TY TNHH TM DV CƠ KHÍ HÀ NỘI",
        "description":
            "Mua hàng từ nhà cung cấp CÔNG TY TNHH TM DV CƠ KHÍ HÀ NỘI theo hoá đơn số 00002500",
        "amount": 8200000
      },
      {
        "postingDate": "12/08/2024",
        "orderNumber": "MH24-000584",
        "invoiceNo": "00002501",
        "customer": "CÔNG TY TNHH XUẤT NHẬP KHẨU PHƯƠNG NAM",
        "description":
            "Mua hàng từ nhà cung cấp CÔNG TY TNHH XUẤT NHẬP KHẨU PHƯƠNG NAM theo hoá đơn số 00002501",
        "amount": 9500000
      },
      {
        "postingDate": "13/08/2024",
        "orderNumber": "MH24-000585",
        "invoiceNo": "00002502",
        "customer": "CÔNG TY CỔ PHẦN THIẾT BỊ CÔNG NGHIỆP MINH PHÁT",
        "description":
            "Mua hàng từ nhà cung cấp CÔNG TY CỔ PHẦN THIẾT BỊ CÔNG NGHIỆP MINH PHÁT theo hoá đơn số 00002502",
        "amount": 11250000
      },
      {
        "postingDate": "14/08/2024",
        "orderNumber": "MH24-000586",
        "invoiceNo": "00002503",
        "customer": "CÔNG TY TNHH VẬT LIỆU XÂY DỰNG NHẬT NAM",
        "description":
            "Mua hàng từ nhà cung cấp CÔNG TY TNHH VẬT LIỆU XÂY DỰNG NHẬT NAM theo hoá đơn số 00002503",
        "amount": 7600000
      },
      {
        "postingDate": "15/08/2024",
        "orderNumber": "MH24-000587",
        "invoiceNo": "00002504",
        "customer": "CÔNG TY TNHH THƯƠNG MẠI ĐẠI AN",
        "description":
            "Mua hàng từ nhà cung cấp CÔNG TY TNHH THƯƠNG MẠI ĐẠI AN theo hoá đơn số 00002504",
        "amount": 13350000
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Phiếu bán hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Hiển thị bảng đầy đủ trên tablet và desktop
              return ListView(
                children: data.asMap().entries.map(
                  (entry) {
                    final index = entry.key;
                    final row = entry.value;
                    final isExpanded = _expandedIndex == index;

                    return Column(
                      children: [
                        DataTable(
                          columns: const <DataColumn>[
                            DataColumn(label: Text('Ngày chứng từ')),
                            DataColumn(label: Text('Số chứng từ')),
                            DataColumn(label: Text('Số hóa đơn')),
                            DataColumn(label: Text('Nhà cung cấp')),
                            DataColumn(label: Text('Mô tả')),
                            DataColumn(label: Text('Số tiền sau thuế')),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(Text(row['name']!)),
                                DataCell(Text(row['age']!)),
                                DataCell(Text(row['job']!)),
                                DataCell(
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _expandedIndex =
                                            isExpanded ? null : index;
                                      });
                                    },
                                    child: Text(isExpanded
                                        ? 'Hide Details'
                                        : 'Show Details'),
                                  ),
                                ),
                              ],
                            ),
                            if (isExpanded) ...[
                              DataRow(
                                cells: [
                                  DataCell(Text('Address:')),
                                  DataCell(Text(row['address']!)),
                                  DataCell(Text('Phone:')),
                                  DataCell(Text(row['phone']!)),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ],
                    );
                  },
                ).toList(),
              );
            } else {
              // Trên mobile, hiển thị dạng danh sách dọc (card)
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final row = data[index];
                  final isExpanded = _expandedIndex == index;

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(row['postingDate']!),
                          titleTextStyle: TextStyle(
                              color: const Color.fromARGB(255, 34, 107, 37),
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDetailRow('Số chứng từ', row['orderNumber']),
                              buildDetailRow('Số hóa đơn', row['invoiceNo']),
                              buildDetailRow('Khách hàng', row['customer']),
                              if (isExpanded) ...[
                                buildDetailRow('Mô tả', row['description']),
                                buildDetailRow('Số tiền sau thuế',
                                    row['amount'].toString()),
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
                                setState(() {
                                  _expandedIndex = isExpanded ? null : index;
                                });
                              },
                              child: Text(
                                  isExpanded ? 'Hide Details' : 'Show Details'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
