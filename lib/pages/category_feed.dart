import 'package:flutter/material.dart';
import 'package:kantin/models/product_model.dart';
import 'package:kantin/providers/cart_provider.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/produk_category_card.dart';
import 'package:kantin/widgets/search_card.dart';
import 'package:provider/provider.dart';

class CategoryFeedPage extends StatefulWidget {
  @override
  State<CategoryFeedPage> createState() => _CategoryFeedPageState();
}

class _CategoryFeedPageState extends State<CategoryFeedPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final categoryName = ModalRoute.of(context).settings.arguments as String;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    searchProduct(value) {
      if (value.isEmpty) {
        setState(() {
          productProvider.getProductsByCategory(categoryName);
        });
      } else {
        setState(() {
          productProvider.getProductsBySearch(
              categoryName, value.toLowerCase());
        });
      }
    }

    clearProduct() {
      setState(() {
        productProvider.getProductsByCategory(categoryName);
        searchController.clear();
      });
    }

    Widget header() {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
              color: lightGrayColor, borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: TextField(
              onChanged: (value) {
                searchProduct(value);
              },
              controller: searchController,
              showCursor: true,
              readOnly: false,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: greyColor,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: searchController.text.isEmpty
                        ? lightGrayColor
                        : greyColor,
                  ),
                  onPressed: clearProduct,
                ),
                hintText: 'Cari...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: header(),
      ),
      body: Container(
        child: searchController.text.isEmpty
            ? ListView(
                children: productProvider.productBycategory
                    .map(
                      (product) => ProdukCategoryCard(product),
                    )
                    .toList(),
              )
            : ListView(
                children: productProvider.productBycategorySearch
                    .map(
                      (search) => SearchCard(search),
                    )
                    .toList(),
              ),
      ),
    );
  }
}
