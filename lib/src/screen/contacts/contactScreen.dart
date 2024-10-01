import 'package:flutter/material.dart';
import 'package:loginkeycloakapp/src/utils/gnavWidget.dart';
import '../../utils/icon_title.dart';
import './navContactScreen/contactScreen.dart';
import './navContactScreen/customerScreen.dart';
import './navContactScreen/otherObjectScreen.dart';
import './navContactScreen/supplierScreen.dart';

class ContactScreens extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ContactScreens> {
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
      IconTitle(icon: Icon(Icons.contacts_sharp, size: 24), title: 'Danh bạ'),
      IconTitle(icon: Icon(Icons.person, size: 24), title: 'Khách hàng'),
      IconTitle(icon: Icon(Icons.business, size: 24), title: 'Nhà cung cấp'),
      IconTitle(
          icon: Icon(Icons.accessibility_sharp, size: 24),
          title: 'Đối tượng khác'),
    ];
    return Scaffold(
      body: _buildSelectedScreen(),
      bottomNavigationBar: GnavWidget(
        iconTitleList: iconList,
        onTabChange: _onTabChange,
        initialIndex: _selectedIndex,
      ),
    );
  }

  Widget _buildSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return ContactScreen();
      case 1:
        return CustomerScreen();
      case 2:
        return SupplierScreen();
      case 3:
        return OtherObjectScreen();
      default:
        return ContactScreen();
    }
  }
}
