import 'package:flutter/material.dart';
import 'package:enchanted_emporium/widgets/search_bar.dart';
import 'package:enchanted_emporium/widgets/drawer_menu.dart';
import 'package:enchanted_emporium/widgets/main_layout.dart'; // Импорт main_layout
import 'dart:async';

class HomeScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  HomeScreen({required this.cart});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<Map<String, dynamic>> products = [
    {'title': 'Product 1', 'price': 29.99},
    {'title': 'Product 2', 'price': 39.99},
    {'title': 'Product 3', 'price': 49.99},
    {'title': 'Product 4', 'price': 59.99},
    {'title': 'Product 5', 'price': 69.99},
    {'title': 'Product 6', 'price': 79.99},
  ];
  late List<Map<String, dynamic>> filteredProducts;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    filteredProducts = products;

    // Автоматическая прокрутка
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        if (_currentPage < 2) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = products;
      } else {
        filteredProducts = products
            .where((product) =>
                product['title'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _filterProducts('');
    });
  }

  void _addToCart(String title, double price) {
    setState(() {
      widget.cart.add({'title': title, 'price': price});
    });
  }

  Widget _buildDiscountCard(String title, String discount, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                discount,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(String title, double price, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      shadowColor: Colors.black26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              ),
              child: Center(child: Text(title)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _addToCart(title, price);
              },
              child: Text('Add to cart'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      cart: widget.cart,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Enchanted Emporium'),
          actions: [
            _isSearching
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: _stopSearch,
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _startSearch,
                  ),
          ],
        ),
        drawer: DrawerMenu(),
        body: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _isSearching ? 60.0 : 0.0,
              child: Visibility(
                visible: _isSearching,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomSearchBar(
                          controller: _searchController,
                          onChanged: _filterProducts,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: PageView(
                        controller: _pageController,
                        children: <Widget>[
                          _buildDiscountCard(
                              'Product 1', '20% off', Colors.redAccent),
                          _buildDiscountCard(
                              'Product 2', '30% off', Colors.blueAccent),
                          _buildDiscountCard(
                              'Product 3', '50% off', Colors.greenAccent),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'New arrivals',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('Show all'),
                              ),
                            ],
                          ),
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              return _buildProductCard(
                                  filteredProducts[index]['title'],
                                  filteredProducts[index]['price'],
                                  index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
