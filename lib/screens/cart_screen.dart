import 'package:flutter/material.dart';
import 'package:enchanted_emporium/widgets/main_layout.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  CartScreen({required this.cart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cart.fold(0, (sum, item) => sum + item['price']);

    return MainLayout(
      currentIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Корзина'),
        ),
        body: widget.cart.isEmpty
            ? Center(child: Text('Корзина пуста'))
            : Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cart.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(widget.cart[index]['title']),
                          subtitle: Text(
                              '\$${widget.cart[index]['price'].toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_shopping_cart),
                            onPressed: () {
                              setState(() {
                                widget.cart.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total: \$${totalPrice.toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
