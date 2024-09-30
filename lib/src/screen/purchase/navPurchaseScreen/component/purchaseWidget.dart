import 'package:flutter/material.dart';

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
                  return buildCard(row, context);
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

  Widget buildCard(Map<String, dynamic> row, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(row, context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    children: [
                      buildGridDetail('Ngày hóa đơn', row['postingDate']),
                      buildGridDetail('Số chứng từ', row['orderNumber']),
                      buildGridDetail('Số hóa đơn', row['invoiceNo']),
                      buildGridDetail('Nhà cung cấp', row['suplier']),
                      buildGridDetail('Mô tả', row['description']),
                      buildGridDetail(
                          'Số tiền sau thuế', row['amount'].toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader(Map<String, dynamic> row, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              '${row['postingDate']}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
