import 'package:flutter/material.dart';
import 'package:loginkeycloakapp/src/utils/bottomNav.dart';
import '../../utils/icon_title.dart'; // Import class IconTitle

class AllocationAssetScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AllocationAssetScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(fontSize: 24)),
    Text('Likes Page', style: TextStyle(fontSize: 24)),
    Text('Search Page', style: TextStyle(fontSize: 24)),
    Text('Profile Page', style: TextStyle(fontSize: 24)),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Danh sách icon và title cho GNav
    final iconList = [
      IconTitle(icon: Icon(Icons.home, size: 24), title: 'Home'),
      IconTitle(icon: Icon(Icons.favorite, size: 24), title: 'Likes'),
      IconTitle(icon: Icon(Icons.search, size: 24), title: 'Search'),
      IconTitle(icon: Icon(Icons.person, size: 24), title: 'Profile'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Custom GNav Example'),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomGNavWidget(
        iconTitleList: iconList, // Truyền danh sách icon và title
        initialIndex: 0, // Tab mặc định
        onTabChange: _onTabChange, // Callback khi thay đổi tab
      ),
    );
  }
}
