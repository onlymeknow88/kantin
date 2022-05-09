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
        title: Text(
          'List Product',
          style: TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: bold,
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
                child: ListView(
                  children: productProvider.products
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
