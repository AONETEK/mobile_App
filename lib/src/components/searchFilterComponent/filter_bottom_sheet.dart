import 'package:flutter/material.dart';
import 'date_field.dart';
import 'text_field.dart';
import 'action_buttons.dart';
import 'additional_fields.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _productNameController = TextEditingController();
  final List<bool> _isFieldExpanded = [false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tìm kiếm',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            DateField(
                fromController: _fromDateController,
                toController: _toDateController),
            SizedBox(height: 16),
            TextFieldComponent(
                controller: _descriptionController, label: 'Mô tả'),
            SizedBox(height: 16),
            TextFieldComponent(
                controller: _productNameController, label: 'Tên sản phẩm'),
            SizedBox(height: 16),
            AdditionalFields(isFieldExpanded: _isFieldExpanded),
            SizedBox(height: 16),
            ActionButtons(
              onAdd: () => _toggleField(true),
              onRemove: () => _toggleField(false),
              onSearch: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleField(bool isAdding) {
    setState(() {
      for (int i = 0; i < _isFieldExpanded.length; i++) {
        if (isAdding && !_isFieldExpanded[i]) {
          _isFieldExpanded[i] = true;
          break;
        } else if (!isAdding && _isFieldExpanded[i]) {
          _isFieldExpanded[i] = false;
          break;
        }
      }
    });
  }
}
