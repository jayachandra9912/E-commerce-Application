import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/product_provider.dart';
import 'package:ecommerce_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_detail_page.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _sortOption = 'price';
  String? _filterCategory;
  double? _minPrice = 0;
  double? _maxPrice = 1000;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() {
    Provider.of<ProductProvider>(context, listen: false).fetchProducts(
      sortOption: _sortOption,
      category: _filterCategory,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce App'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _sortOption = value;
                _fetchProducts();
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'price',
                child: Text('Sort by Price'),
              ),
              PopupMenuItem(
                value: 'popularity',
                child: Text('Sort by Popularity'),
              ),
              PopupMenuItem(
                value: 'rating',
                child: Text('Sort by Rating'),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterOptions(),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    final product = provider.products[index];
                    return Card(
                      child: ListTile(
                        leading:
                            Image.network(product.image, fit: BoxFit.cover),
                        title: Text(product.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('\$${product.price}'),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < product.rating.round()
                                      ? Icons.star
                                      : Icons.star_border,
                                );
                              }),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          DropdownButtonFormField<String?>(
            decoration: InputDecoration(labelText: 'Category'),
            value: _filterCategory,
            items: [
              DropdownMenuItem(value: null, child: Text('All Categories')),
              // Add more categories as needed
              DropdownMenuItem(
                  value: 'electronics', child: Text('Electronics')),
              DropdownMenuItem(value: 'jewelery', child: Text('Jewelery')),
              DropdownMenuItem(
                  value: "men's clothing", child: Text("Men's Clothing")),
              DropdownMenuItem(
                  value: "women's clothing", child: Text("Women's Clothing")),
            ],
            onChanged: (value) {
              setState(() {
                _filterCategory = value;
                _fetchProducts();
              });
            },
          ),
          RangeSlider(
            values: RangeValues(_minPrice ?? 0, _maxPrice ?? 1000),
            min: 0,
            max: 1000,
            divisions: 100,
            labels: RangeLabels(
              '\$${_minPrice?.toStringAsFixed(0) ?? '0'}',
              '\$${_maxPrice?.toStringAsFixed(0) ?? '1000'}',
            ),
            onChanged: (values) {
              setState(() {
                _minPrice = values.start;
                _maxPrice = values.end;
                _fetchProducts();
              });
            },
          ),
        ],
      ),
    );
  }
}
