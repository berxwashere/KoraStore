import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<int> _favoriteIds = {};

  Set<int> get favoriteIds => _favoriteIds;

  bool isFavorite(int productId) => _favoriteIds.contains(productId);

  void toggleFavorite(int productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifyListeners();
  }
}
