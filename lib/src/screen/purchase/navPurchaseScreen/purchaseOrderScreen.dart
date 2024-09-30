import 'package:flutter/material.dart';
import 'package:loginkeycloakapp/src/screen/purchase/navPurchaseScreen/purchase/purchaseWidget.dart';
import 'package:loginkeycloakapp/src/screen/purchase/navPurchaseScreen/purchase/tableWidget.dart';

class PurchaseOrderScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// late final Tablewidget tablewidget;

class _HomePageState extends State<PurchaseOrderScreen> {
  int? _expandedIndex;
  final List<String> _additionalFields = [
    'Số chứng từ',
    'Số hóa đơn',
  ];
  final List<bool> _isFieldExpanded = [false, false];
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _productNameController = TextEditingController();

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép scroll nếu nội dung dài
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tìm kiếm',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _fromDateController,
                            decoration: InputDecoration(
                              labelText: 'Từ ngày',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              prefixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _toDateController,
                            decoration: InputDecoration(
                              labelText: 'Đến ngày',
                              prefixIcon: Icon(Icons.calendar_today),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _productNameController,
                      decoration: InputDecoration(
                        labelText: 'Tên sản phẩm',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: _isFieldExpanded.asMap().entries.map((entry) {
                        int index = entry.key;
                        if (entry.value) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: _additionalFields[index],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.add,
                                  color: Theme.of(context).primaryColor),
                              onPressed: () {
                                setState(() {
                                  _toggleField(true);
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove,
                                  color: Theme.of(context).primaryColor),
                              onPressed: () {
                                setState(() {
                                  _toggleField(false);
                                });
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý tìm kiếm tại đây
                            Navigator.of(context)
                                .pop(); // Đóng bottom sheet sau khi tìm kiếm
                          },
                          child: Text('Tìm kiếm'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 106, 198, 108),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _toggleField(bool isAdding) {
    setState(() {
      for (int i = 0; i < _isFieldExpanded.length; i++) {
        if (isAdding) {
          if (!_isFieldExpanded[i]) {
            _isFieldExpanded[i] = true;
            break;
          }
        } else {
          if (_isFieldExpanded[i]) {
            _isFieldExpanded[i] = false;
            break;
          }
        }
      }
    });
  }

  final List<Map<String, dynamic>> data = [
    {
      "postingDate": "28/06/2024",
      "orderNumber": "MH24-000024",
      "invoiceNo": "00002495",
      "suplier": "CÔNG TY CỔ PHẦN KIẾN TRÚC TRẺ",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY CỔ PHẦN KIẾN TRÚC TRẺ theo hoá đơn số 00000323",
      "amount": 20000000
    },
    {
      "postingDate": "30/06/2024",
      "orderNumber": "MH24-000025",
      "invoiceNo": "00002496",
      "suplier": "CÔNG TY TNHH NỘI THẤT ĐỨC PHÁT",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH NỘI THẤT ĐỨC PHÁT theo hoá đơn số 00000324",
      "amount": 50000000
    },
    {
      "postingDate": "01/07/2024",
      "orderNumber": "MH24-000026",
      "invoiceNo": "00002497",
      "suplier": "CÔNG TY TNHH XÂY DỰNG HỒNG PHÚ",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH XÂY DỰNG HỒNG PHÚ theo hoá đơn số 00000325",
      "amount": 32000000
    },
    {
      "postingDate": "05/07/2024",
      "orderNumber": "MH24-000027",
      "invoiceNo": "00002498",
      "suplier": "CÔNG TY TNHH SẢN XUẤT THIẾT BỊ HÀNG HẢI",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH SẢN XUẤT THIẾT BỊ HÀNG HẢI theo hoá đơn số 00000326",
      "amount": 42000000
    },
    {
      "postingDate": "10/07/2024",
      "orderNumber": "MH24-000028",
      "invoiceNo": "00002499",
      "suplier": "CÔNG TY TNHH TM DV CƠ KHÍ VIỆT PHÁT",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH TM DV CƠ KHÍ VIỆT PHÁT theo hoá đơn số 00000327",
      "amount": 27500000
    },
    {
      "postingDate": "15/07/2024",
      "orderNumber": "MH24-000029",
      "invoiceNo": "00002500",
      "suplier": "CÔNG TY TNHH VẬT LIỆU XÂY DỰNG ANH KHOA",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH VẬT LIỆU XÂY DỰNG ANH KHOA theo hoá đơn số 00000328",
      "amount": 67000000
    },
    {
      "postingDate": "18/07/2024",
      "orderNumber": "MH24-000030",
      "invoiceNo": "00002501",
      "suplier": "CÔNG TY CỔ PHẦN CƠ KHÍ XÂY DỰNG MINH ANH",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY CỔ PHẦN CƠ KHÍ XÂY DỰNG MINH ANH theo hoá đơn số 00000329",
      "amount": 45000000
    },
    {
      "postingDate": "22/07/2024",
      "orderNumber": "MH24-000031",
      "invoiceNo": "00002502",
      "suplier": "CÔNG TY TNHH VẬT LIỆU CHỊU NHIỆT HÙNG CƯỜNG",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH VẬT LIỆU CHỊU NHIỆT HÙNG CƯỜNG theo hoá đơn số 00000330",
      "amount": 38500000
    },
    {
      "postingDate": "25/07/2024",
      "orderNumber": "MH24-000032",
      "invoiceNo": "00002503",
      "suplier": "CÔNG TY TNHH CƠ ĐIỆN TỬ QUANG MINH",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH CƠ ĐIỆN TỬ QUANG MINH theo hoá đơn số 00000331",
      "amount": 56000000
    },
    {
      "postingDate": "28/07/2024",
      "orderNumber": "MH24-000033",
      "invoiceNo": "00002504",
      "suplier": "CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN theo hoá đơn số 00000332",
      "amount": 71000000
    },
    {
      "postingDate": "28/07/2024",
      "orderNumber": "MH24-000033",
      "invoiceNo": "00002504",
      "suplier": "CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN theo hoá đơn số 00000332",
      "amount": 71000000
    },
    {
      "postingDate": "28/07/2024",
      "orderNumber": "MH24-000033",
      "invoiceNo": "00002504",
      "suplier": "CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN theo hoá đơn số 00000332",
      "amount": 71000000
    },
    {
      "postingDate": "28/07/2024",
      "orderNumber": "MH24-000033",
      "invoiceNo": "00002504",
      "suplier": "CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN theo hoá đơn số 00000332",
      "amount": 71000000
    },
    {
      "postingDate": "28/07/2024",
      "orderNumber": "MH24-000033",
      "invoiceNo": "00002504",
      "suplier": "CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN theo hoá đơn số 00000332",
      "amount": 71000000
    },
    {
      "postingDate": "28/07/2024",
      "orderNumber": "MH24-000033",
      "invoiceNo": "00002504",
      "suplier": "CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN theo hoá đơn số 00000332",
      "amount": 71000000
    },
    {
      "postingDate": "28/07/2024",
      "orderNumber": "MH24-000033",
      "invoiceNo": "00002504",
      "suplier": "CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN theo hoá đơn số 00000332",
      "amount": 71000000
    },
    {
      "postingDate": "28/07/2024",
      "orderNumber": "MH24-000033",
      "invoiceNo": "00002504",
      "suplier": "CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN theo hoá đơn số 00000332",
      "amount": 71000000
    },
    {
      "postingDate": "28/07/2024",
      "orderNumber": "MH24-000033",
      "invoiceNo": "00002504",
      "suplier": "CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN",
      "description":
          "Mua hàng từ nhà cung cấp CÔNG TY TNHH THƯƠNG MẠI XUẤT NHẬP KHẨU VIỆT TIẾN theo hoá đơn số 00000332",
      "amount": 71000000
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Purchasewidget(
      title: "Phiếu mua hàng",
      showFilterDialog: () => _showFilterBottomSheet(context),
      data: data,
      // icon: icon,
      iconButton: IconButton(
        onPressed: () => _showFilterBottomSheet(context),
        icon: Icon(Icons.filter_alt),
      ),
      expandedIndex: _expandedIndex,
      // tablewidget: tablewidget
    );
  }
}
