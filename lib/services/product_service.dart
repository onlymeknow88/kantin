import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kantin/models/product_model.dart';

class ProductService {
  String baseUrl = 'http://103.183.75.223/api';

  Future<List<ProductModel>> getProducts() async {
    var url = Uri.parse('$baseUrl/products?tags=Recommended');
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

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

  Future<List<ProductModel>> getSearchProduct(String name) async {
    var url = Uri.parse('$baseUrl/products');
    url = url.replace(queryParameters: {'name': name.toString()});

    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

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

  Future<List<ProductModel>> getSearchProductByCategory(
      String name, String cari) async {
    var url = Uri.parse('$baseUrl/products-search');
    url = url.replace(
        queryParameters: {'name': name.toString(), 'cari': cari.toString()});
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ProductModel> productBycategorySearch = [];

      for (var item in data) {
        productBycategorySearch.add(ProductModel.fromJson(item));
      }

      return productBycategorySearch;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String name) async {
    var url = Uri.parse('$baseUrl/products-category');
    url = url.replace(queryParameters: {'name': name.toString()});
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ProductModel> productBycategory = [];

      for (var item in data) {
        productBycategory.add(ProductModel.fromJson(item));
      }

      return productBycategory;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }
}
