import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;
  String _selectedCategory = 'All';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedCategory => _selectedCategory;

  List<String> get categories {
    final cats = _products.map((p) => p.category).toSet().toList();
    cats.sort();
    return ['All', ...cats];
  }

  List<Product> get filteredProducts {
    if (_selectedCategory == 'All') return _products;
    return _products.where((p) => p.category == _selectedCategory).toList();
  }

  List<Product> searchProducts(String query) {
    if (query.isEmpty) return filteredProducts;
    final lower = query.toLowerCase();
    return filteredProducts
        .where((p) => p.title.toLowerCase().contains(lower))
        .toList();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final apiService = ApiService();
      _products = await apiService.fetchProducts();
    } catch (e) {
      _error = 'Connection error. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
  }

  Product? getProductById(int id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
