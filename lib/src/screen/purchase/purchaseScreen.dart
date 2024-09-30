import 'package:flutter/material.dart';
//
import '../../utils/icon_title.dart';
import '../../utils/bottomNav.dart';
import './navPurchaseScreen/invoiceScreen.dart';
import './navPurchaseScreen/purchaseOrderScreen.dart';
import './navPurchaseScreen/warehouseReceiptScreen.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PurchaseScreen> {
  int _selectedIndex = 0;
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final iconList = [
      IconTitle(icon: Icon(Icons.receipt, size: 24), title: 'Phiếu mua hàng'),
      IconTitle(icon: Icon(Icons.receipt_long, size: 24), title: 'Hóa đơn'),
      IconTitle(icon: Icon(Icons.inventory, size: 24), title: 'Phiếu nhập kho'),
      IconTitle(icon: Icon(Icons.undo, size: 24), title: 'Hàng bán trả lại'),
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
        return PurchaseOrderScreen();
      case 1:
        return InvoiceScreen();
      case 2:
        return WarehouseReceiptScreen();
      default:
        return PurchaseOrderScreen();
    }
  }
}
