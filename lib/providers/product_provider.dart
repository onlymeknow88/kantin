import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kantin/models/product_model.dart';
import 'package:kantin/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  ProductModel _addProduct;

  ProductModel get addProduct => _addProduct;

  set addProduct(ProductModel addProduct) {
    _addProduct = addProduct;
    notifyListeners();
  }

  Future<bool> addProducts(String name, String price, String tags,
      String categoryId, String files) async {
    try {
      if (await ProductService()
          .addProducts(name, price, tags, categoryId, files)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteProducts(int id) async {
    try {
      if (await ProductService().deleteProducts(id)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;
    } catch (e) {
      print(e);
    }
  }

  List<ProductModel> _productByCategories = [];

  List<ProductModel> get productBycategory => _productByCategories;

  set productBycategory(List<ProductModel> productBycategory) {
    _productByCategories = productBycategory;
    notifyListeners();
  }

  Future<void> getProductsByCategory(String name) async {
    try {
      List<ProductModel> productBycategory =
          await ProductService().getProductsByCategory(name);
      _productByCategories = productBycategory;
    } catch (e) {
      print(e);
    }
  }

  List<ProductModel> _productByCategoriesSearch = [];

  List<ProductModel> get productBycategorySearch => _productByCategoriesSearch;

  set productBycategorySearch(List<ProductModel> productBycategorySearch) {
    _productByCategoriesSearch = productBycategorySearch;
    notifyListeners();
  }

  Future<bool> getProductsBySearch(String name, String cari) async {
    try {
      List<ProductModel> productBycategorySearch =
          await ProductService().getSearchProductByCategory(name, cari);
      _productByCategoriesSearch = productBycategorySearch;
    } catch (e) {
      print(e);
    }
  }

  List<ProductModel> _productSearch = [];

  List<ProductModel> get productSearch => _productSearch;

  set productSearch(List<ProductModel> productSearch) {
    _productSearch = productSearch;
    notifyListeners();
  }

  Future<bool> getSearch(String name) async {
    try {
      List<ProductModel> productSearch =
          await ProductService().getSearchProduct(name);
      _productSearch = productSearch;
    } catch (e) {
      print(e);
    }
  }
}
