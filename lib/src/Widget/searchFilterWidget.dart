import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.filter_alt),
      onPressed: () => _showFilterBottomSheet(context),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final _fromDateController = TextEditingController();
    final _toDateController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _productNameController = TextEditingController();
    final List<String> _additionalFields = ['Số chứng từ', 'Số hóa đơn'];
    final List<bool> _isFieldExpanded = [false, false];

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
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tìm kiếm',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    _buildDateField(context, _fromDateController, 'Từ ngày'),
                    SizedBox(height: 16),
                    _buildDateField(context, _toDateController, 'Đến ngày'),
                    SizedBox(height: 16),
                    _buildTextField(_descriptionController, 'Mô tả'),
                    SizedBox(height: 16),
                    _buildTextField(_productNameController, 'Tên sản phẩm'),
                    SizedBox(height: 16),
                    _buildAdditionalFields(
                        context, _additionalFields, _isFieldExpanded, setState),
                    SizedBox(height: 16),
                    _buildActionButtons(
                        context, setState, _isFieldExpanded, _additionalFields),
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

  Widget _buildDateField(
      BuildContext context, TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }

  Widget _buildAdditionalFields(BuildContext context, List<String> fields,
      List<bool> isExpanded, StateSetter setState) {
    return Column(
      children: isExpanded.asMap().entries.map((entry) {
        int index = entry.key;
        return entry.value
            ? Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: _buildTextField(TextEditingController(), fields[index]),
              )
            : SizedBox.shrink();
      }).toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context, StateSetter setState,
      List<bool> isExpanded, List<String> fields) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
              onPressed: () {
                setState(() {
                  for (int i = 0; i < isExpanded.length; i++) {
                    if (!isExpanded[i]) {
                      isExpanded[i] = true;
                      break;
                    }
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.remove, color: Theme.of(context).primaryColor),
              onPressed: () {
                setState(() {
                  for (int i = isExpanded.length - 1; i >= 0; i--) {
                    if (isExpanded[i]) {
                      isExpanded[i] = false;
                      break;
                    }
                  }
                });
              },
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Tìm kiếm'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 106, 198, 108),
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
