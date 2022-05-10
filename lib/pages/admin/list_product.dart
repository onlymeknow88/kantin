import 'package:flutter/material.dart';
import 'package:kantin/pages/admin/add_product.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/custom_page_route.dart';
import 'package:kantin/widgets/product_list_card.dart';
import 'package:provider/provider.dart';

class ListPorductPage extends StatefulWidget {
  @override
  State<ListPorductPage> createState() => _ListPorductPageState();
}

class _ListPorductPageState extends State<ListPorductPage> {
  TextEditingController searchController = TextEditingController();
  void initState() {
    // TODO: implement initState
    getProduct();
    super.initState();
  }

  Future<void> getProduct() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    setState(() {});
  }

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
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: blackColor,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(CustomPageRoute(child: AddProdukPage()));
            },
          ),
        ],
      );
    }

    Widget content() {
      return RefreshIndicator(
        onRefresh: getProduct,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: searchController.text.isEmpty
                    ? ListView(
                        children: productProvider.products
                            .map(
                              (product) => ProductListCard(product),
                            )
                            .toList(),
                      )
                    : ListView(
                        children: productProvider.productSearch
                            .map(
                              (product) => ProductListCard(product),
                            )
                            .toList(),
                      ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: header(),
      ),
      body: content(),
    );
  }
}
