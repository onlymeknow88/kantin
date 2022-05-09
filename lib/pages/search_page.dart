import 'package:flutter/material.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/produk_search_card.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    searchProduct(value) {
      if (value.isEmpty) {
        setState(() {});
      } else {
        setState(() {
          productProvider.getSearch(value.toLowerCase());
        });
      }
    }

    clearProduct() {
      setState(() {
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
              autofocus: true,
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

    Widget produkSearch() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: searchController.text.isEmpty
            ? Center(child: Text('Pencarian Produk!'))
            : ListView(
                children: productProvider.productSearch
                    .map(
                      (product) => ProdukSearchCard(product),
                    )
                    .toList(),
              ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: header(),
      ),
      body: produkSearch(),
    );
  }
}
