import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kantin/models/product_model.dart';

class ProductService {
  String baseUrl = 'http://103.183.75.223/api';

  Future<List<ProductModel>> getProducts() async {
    var url = '$baseUrl/products?tags=Recommended';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }
}