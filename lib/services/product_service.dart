import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kantin/models/product_model.dart';

class ProductService {
  String baseUrl = 'http://103.183.75.223/api';

  Future<bool> addProducts(
    String name,
    String price,
    String tags,
    String categoryId,
    String image,
  ) async {
    var uri = Uri.parse('$baseUrl/add-products');

    var request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('image', image));
    request.fields['name'] = name;
    request.fields['price'] = price;
    request.fields['tags'] = tags;
    request.fields['categories_id'] = categoryId;
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    final responseData = json.decode(respStr);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ProductModel>> getProducts() async {
    var url = Uri.parse('$baseUrl/products');
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
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

  Future<bool> deleteProducts(int id) async {
    var uri = Uri.parse('$baseUrl/delete-products');

    uri = uri.replace(queryParameters: {'id': id.toString()});

    var request = http.MultipartRequest('POST', uri);

    var response = await request.send();

    final respStr = await response.stream.bytesToString();

    final responseData = json.decode(respStr);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
