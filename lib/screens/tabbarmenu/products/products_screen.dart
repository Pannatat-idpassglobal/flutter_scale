import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  //toggle Vetween
  bool _isGridView = true;
  //func toggle _isGridView
  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _toggleView,
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
          )
        ],
      ),
      body: _isGridView ? _gradView() : _listView(),
    );
  }

  //_listView Widget
  Widget _listView() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              print('Item $index click');
            },
            title: Text('Item $index'),
          );
        });
  }

  //_GridView Widget
}

Widget _gradView() {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemCount: 12,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          print('Item $index click');
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          child: Center(
            child: Text("Item $index"),
          ),
        ),
      );
    },
  );
}
