import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  double get total => subtotal;

  void addToCart(Product product) {
    final existingIndex =
        _items.indexWhere((item) => item.productId == product.id);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(
        productId: product.id,
        title: product.title,
        price: product.price,
        image: product.image,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  void incrementQuantity(int productId) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int productId) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(int productId) {
    return _items.any((item) => item.productId == productId);
  }
}
