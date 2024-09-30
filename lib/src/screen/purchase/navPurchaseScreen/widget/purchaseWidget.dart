import 'package:flutter/material.dart';
import '../../../../components/cardComponent/buildCard.dart';

class Purchasewidget extends StatefulWidget {
  final String title;
  final void Function() showFilterDialog;
  final List<Map<String, dynamic>> data;
  final IconButton iconButton;
  final int? expandedIndex;

  Purchasewidget({
    Key? key,
    required this.title,
    required this.showFilterDialog,
    required this.data,
    required this.iconButton,
    required this.expandedIndex,
  }) : super(key: key);

  @override
  _PurchasewidgetState createState() => _PurchasewidgetState();
}

class _PurchasewidgetState extends State<Purchasewidget> {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = false;
  bool _hasMoreData = true;
  final int _perPage = 5;
  late ScrollController _scrollController;
  // late final BuildgridDetail buildgridDetail;

  @override
  void initState() {
    super.initState();
    _items = widget.data.take(_perPage).toList();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_isLoading &&
        _hasMoreData) {
      _fetchMoreItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: widget.showFilterDialog,
            icon: Icon(Icons.filter_alt),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth > 600 ? 3 : 1,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 3 / 2,
              ),
              itemCount: _hasMoreData ? _items.length + 1 : _items.length,
              itemBuilder: (context, index) {
                if (index == _items.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  final row = _items[index];
                  return BuildCard(
                    row: row,
                    listLabel: [
                      "Ngày hóa đơn",
                      "Số chứng từ",
                      "Số hóa đơn",
                      "Nhà cung cấp",
                      "Mô tả",
                      "Số tiền sau thuế"
                    ],
                    listRow: [
                      "postingDate",
                      "orderNumber",
                      "invoiceNo",
                      "suplier",
                      "description",
                      "amount"
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _fetchMoreItems() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    List<Map<String, dynamic>> newItems =
        widget.data.skip(_items.length).take(_perPage).toList();

    if (newItems.isEmpty) {
      setState(() {
        _hasMoreData = false;
      });
    } else {
      setState(() {
        _items.addAll(newItems);
      });
    }

    setState(() {
      _isLoading = false;
    });
  }
}
