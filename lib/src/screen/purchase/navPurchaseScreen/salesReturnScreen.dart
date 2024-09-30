import 'package:flutter/material.dart';
import '../../../components/searchFilterComponent/filter_bottom_sheet.dart';
import 'widget/purchaseWidget.dart';

class SalesreturnScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SalesreturnScreen> {
  int? _expandedIndex;

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Purchasewidget(
              title: 'Danh sách đơn bị hoàn trả',
              showFilterDialog: () => _showFilterBottomSheet(context),
              data: data,
              iconButton: IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
              expandedIndex: _expandedIndex,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FilterBottomSheet();
      },
    );
  }
}
