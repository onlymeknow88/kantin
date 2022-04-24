import 'package:flutter/material.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/produk_search_card.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    color: greyColor,
                  ),
                  onPressed: () {
                    /* Clear the search field */
                  },
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
        child: ListView(
          children: [
            ProdukSearchCard(),
            ProdukSearchCard(),
            ProdukSearchCard(),
            ProdukSearchCard(),
            ProdukSearchCard(),
            ProdukSearchCard(),
            ProdukSearchCard(),
            ProdukSearchCard(),
            ProdukSearchCard(),
            ProdukSearchCard(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: header(),
      ),
      body: produkSearch(),
    );
  }
}
