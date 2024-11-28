// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';

class ApiService {
  static const String _url = 'https://api.escuelajs.co/api/v1/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
