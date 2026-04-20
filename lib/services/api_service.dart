import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

/// Centralized Network Service
/// This class handles all raw HTTP requests and JSON parsing. 
/// Providers should call these functions and never handle `http` directly.
class ApiService {
  final String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception("Couldn't load products. Server is down.");
    }
  }
}
