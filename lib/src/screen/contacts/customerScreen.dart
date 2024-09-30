import 'package:flutter/material.dart';
//
import '../../utils/icon_title.dart';
import '../../utils/bottomNav.dart';
import '../../Widget/detailsRow.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CustomerScreen> {
  int _selectedIndex = 0;
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int? selectedIndex;
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final iconList = [
      IconTitle(icon: Icon(Icons.receipt, size: 24), title: 'Phiếu bán hàng'),
      IconTitle(
          icon: Icon(Icons.receipt_long, size: 24), title: 'Đơn đặt hàng'),
      IconTitle(icon: Icon(Icons.receipt, size: 24), title: 'Hóa đơn'),
      IconTitle(icon: Icon(Icons.inventory, size: 24), title: 'Phiếu xuất kho'),
      IconTitle(icon: Icon(Icons.undo, size: 24), title: 'Hàng bán trả lại'),
      IconTitle(icon: Icon(Icons.receipt, size: 24), title: 'Hóa đơn'),
      IconTitle(icon: Icon(Icons.receipt, size: 24), title: 'Hóa đơn'),
    ];

    final List<Map<String, dynamic>> data = [
      // Thêm nhiều dữ liệu khác vào đây nếu cần
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDetailRow('Số chứng từ', row['orderNumber']),
                              buildDetailRow('Số hóa đơn', row['invoiceNo']),
                              buildDetailRow('Nhà cung cấp', row['suplier']),
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
      bottomNavigationBar: CustomGNavWidget(
        iconTitleList: iconList,
        onTabChange: _onTabChange,
        initialIndex: _selectedIndex,
      ),
    );
  }
}
