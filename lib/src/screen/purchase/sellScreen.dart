import 'package:flutter/material.dart';
//
import '../../utils/icon_title.dart';
import '../../utils/bottomNav.dart';
import './navSellScreen/invoiceScreen.dart';
import './navSellScreen/saleOrderScreen.dart';
import './navSellScreen/salesReceiptScreen.dart';
import './navSellScreen/warehouseReceiptScreen.dart';

class SellScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SellScreen> {
  int _selectedIndex = 0;
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final iconList = [
      IconTitle(icon: Icon(Icons.receipt, size: 24), title: 'Phiếu bán hàng'),
      IconTitle(icon: Icon(Icons.receipt_long, size: 24), title: 'Hóa đơn'),
      IconTitle(icon: Icon(Icons.inventory, size: 24), title: 'Phiếu xuất kho'),
      IconTitle(icon: Icon(Icons.receipt, size: 24), title: 'Đơn đặt hàng'),
    ];
    return Scaffold(
      body: _buildSelectedScreen(),
      bottomNavigationBar: CustomGNavWidget(
        iconTitleList: iconList,
        onTabChange: _onTabChange,
        initialIndex: _selectedIndex,
      ),
    );
  }

  Widget _buildSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return SalesReceiptScreen();
      case 1:
        return InvoiceScreen();
      case 2:
        return WarehouseReceiptScreen();
      case 3:
        return SaleOrderScreen();
      default:
        return SalesReceiptScreen();
    }
  }
}
