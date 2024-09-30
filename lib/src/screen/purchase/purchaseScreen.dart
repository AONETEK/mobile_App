import 'package:flutter/material.dart';
//
import '../../utils/icon_title.dart';
import '../../utils/bottomNav.dart';
import './navPurchaseScreen/invoiceScreen.dart';
import './navPurchaseScreen/purchaseOrderScreen.dart';
import './navPurchaseScreen/warehouseReceiptScreen.dart';
import './navPurchaseScreen/salesReturnScreen.dart';
import './navPurchaseScreen/orderScreen.dart';

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
      IconTitle(
          icon: Icon(Icons.shopping_cart, size: 24), title: 'Đơn đặt hàng'),
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
        // return SalesreturnScreen();
        return OrderScreen();
      case 1:
        return PurchaseOrderScreen();
      case 2:
        return InvoiceScreen();
      case 3:
        return WarehouseReceiptScreen();
      case 4:
        return SalesreturnScreen();
      default:
        return PurchaseOrderScreen();
    }
  }
}
