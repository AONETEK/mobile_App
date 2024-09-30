import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final List<String> _additionalFields = [
    'Số chứng từ',
    'Số hóa đơn',
  ];
  final List<bool> _isFieldExpanded = [false, false];
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _productNameController = TextEditingController();

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

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
          child: SingleChildScrollView(
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
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
                            _toggleField(true);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.remove,
                              color: Theme.of(context).primaryColor),
                          onPressed: () {
                            _toggleField(false);
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle search logic here
                        Navigator.of(context)
                            .pop(); // Close bottom sheet after search
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showFilterBottomSheet(context),
      child: Text('Mở bộ lọc'),
    );
  }
}
