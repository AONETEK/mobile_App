import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import './icon_title.dart';

// Widget tái sử dụng cho GNav
class GnavWidget extends StatefulWidget {
  final List<IconTitle> iconTitleList;
  final Function(int) onTabChange; // Callback khi thay đổi tab
  final int initialIndex; // Vị trí tab ban đầu

  GnavWidget({
    required this.iconTitleList,
    required this.onTabChange,
    this.initialIndex = 0,
  });

  @override
  _CustomGNavWidgetState createState() => _CustomGNavWidgetState();
}

class _CustomGNavWidgetState extends State<GnavWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey,
            gap: 8,
            padding: EdgeInsets.all(20),
            selectedIndex: _selectedIndex, // Giữ vị trí của tab đã chọn
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
              widget.onTabChange(index); // Gọi callback khi tab thay đổi
            },
            tabs: widget.iconTitleList.map((item) {
              return GButton(
                icon: item.icon.icon!, // Sử dụng icon
                text: item.title, // Sử dụng title
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
