import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts(int limit) async {
    final response =
        await http.get(Uri.parse('$baseUrl/products?limit=$limit'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      // Handle different HTTP status codes gracefully
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  Future<Product> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Product.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load product details: ${response.statusCode}');
    }
  }

  // Add more methods as needed to interact with other API endpoints
}
