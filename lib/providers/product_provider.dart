// providers/product_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts(
      {String? sortOption,
      String? category,
      double? minPrice,
      double? maxPrice}) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, String> queryParameters = {
      if (sortOption != null) 'sort': sortOption,
      if (category != null) 'category': category,
      if (minPrice != null) 'price_min': minPrice.toString(),
      if (maxPrice != null) 'price_max': maxPrice.toString(),
    };

    // Adjust the URL based on how the API expects sort and filter parameters
    final uri = Uri.https('fakestoreapi.com', '/products', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _products = data.map((json) => Product.fromJson(json)).toList();

      // Perform client-side sorting if the API does not support sorting
      if (sortOption == 'price') {
        _products.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortOption == 'popularity') {
        // Assuming popularity can be derived from rating or other attributes
        _products.sort((a, b) => b.rating.compareTo(a.rating));
      } else if (sortOption == 'rating') {
        _products.sort((a, b) => b.rating.compareTo(a.rating));
      }
    } else {
      throw Exception('Failed to load products');
    }

    _isLoading = false;
    notifyListeners();
  }
}
