import 'package:flutter/material.dart';
import 'package:kantin/pages/cart_page.dart';
import 'package:kantin/pages/search_page.dart';
import 'package:kantin/providers/cart_provider.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/custom_page_route.dart';
import 'package:kantin/widgets/produk_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget searchInput() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 44,
            width: MediaQuery.of(context).size.width * 0.764,
            margin: EdgeInsets.only(
              left: 16,
              top: 16,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: lightGrayColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/search');
                      // Navigator.of(context)
                      //     .push(CustomPageRoute(child: SearchPage()));
                    },
                    child: Image.asset(
                      'assets/icon_search.png',
                      width: 22,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      onTap: () {
                        // print(value); //go to search page
                        Navigator.pushNamed(context, '/search');
                        // Navigator.of(context)
                        //     .push(CustomPageRoute(child: SearchPage()));
                      },
                      showCursor: false,
                      readOnly: true,
                      style: blackTextStyle,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Cari...',
                        hintStyle: subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              // print('go to search page');
              Navigator.pushNamed(context, '/cart');
              // Navigator.of(context).push(CustomPageRoute(child: CartPage()));
            },
            child: Container(
              height: 44,
              width: 44,
              margin: EdgeInsets.only(
                top: 16,
                right: 16,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      );
    }

    Widget diskonCard() {
      return Container(
          margin: EdgeInsets.only(
            top: 20,
            left: 16,
            right: 16,
          ),
          child: Center(
            child: Image.asset('assets/pic_diskon.png'),
          ));
    }

    Widget Categories() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: blueColor,
                ),
                child: Text(
                  'All',
                  style: whiteTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: lightGrayColor,
                ),
                child: Text(
                  'Nasi',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: lightGrayColor,
                ),
                child: Text(
                  'Mie Ayam',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: lightGrayColor,
                ),
                child: Text(
                  'Minuman',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: lightGrayColor,
                ),
                child: Text(
                  'Bakso',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: lightGrayColor,
                ),
                child: Text(
                  'Gorengan',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget recomendedTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Recomended',
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
      );
    }

    Widget recomendedProduk() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
          children: productProvider.products
              .map(
                (product) => ProdukCard(product),
              )
              .toList(),
        ),
      );
    }

    return ListView(
      children: [
        searchInput(),
        diskonCard(),
        Categories(),
        recomendedTitle(),
        recomendedProduk(),
      ],
    );
  }
}
