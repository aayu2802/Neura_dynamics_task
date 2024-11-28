// lib/providers/product_provider.dart
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _loading = false;
  String _error = '';

  List<Product> get products => _products;
  bool get loading => _loading;
  String get error => _error;

  /// Fetches products from the API and updates the state
  Future<void> getProducts() async {
    _loading = true;
    notifyListeners();

    try {
      // Fetch products using the API service
      _products = await ApiService().fetchProducts();

      // Print fetched products for debugging
      for (var product in _products) {
        print('Product: ${product.title}, Category: ${product.category.name}');
      }

      // Reset error state on successful fetch
      _error = '';
    } catch (e) {
      // Capture error and clear product list on failure
      _error = 'Failed to fetch products: $e';
      _products = [];
    } finally {
      // Ensure loading state is reset
      _loading = false;
      notifyListeners();
    }
  }
}
