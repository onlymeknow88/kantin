import 'package:flutter/material.dart';
import 'package:kantin/models/product_model.dart';
import 'package:kantin/providers/cart_provider.dart';
import 'package:kantin/theme.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;
  ProductPage(this.product);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Widget header() {
      // int index = -1;
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 26,
                  ),
                ),
                Icon(
                  Icons.shopping_cart,
                  color: blackColor,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 16,
            ),
            child: Image.network(
              'http://103.183.75.223/' + widget.product.galleries[0].url,
              width: MediaQuery.of(context).size.width,
              height: 310,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    }

    Widget content() {
      // int index = -1;

      return Container(
        width: double.infinity,
        // margin: EdgeInsets.only(top: 17),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.vertical(
          //   top: Radius.circular(24),
          // ),
          color: whiteColor,
        ),
        child: Column(
          children: [
            // NOTE: HEADER
            Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          widget.product.category.name,
                          style: blackTextStyle.copyWith(
                              fontSize: 12, color: greyColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // NOTE: PRICE
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 20,
                left: defaultMargin,
                right: defaultMargin,
              ),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: lightBlueColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Harga',
                    style: primaryTextStyle,
                  ),
                  Text(
                    '\Rp${widget.product.price}',
                    style: priceTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),

            // NOTE: DESCRIPTION
            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.only(
            //     top: defaultMargin,
            //     left: defaultMargin,
            //     right: defaultMargin,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Description',
            //         style: blackTextStyle.copyWith(
            //           fontWeight: medium,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 12,
            //       ),
            //       Text(
            //         widget.product.description,
            //         style: subtitleTextStyle.copyWith(
            //           fontWeight: light,
            //         ),
            //         textAlign: TextAlign.justify,
            //       ),
            //     ],
            //   ),
            // ),

            SizedBox(
              height: 80,
            ),

            // NOTE: BUTTONS
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(defaultMargin),
              child: Row(
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(
                  //     //     builder: (context) => DetailChatPage(widget.product),
                  //     //   ),
                  //     // );
                  //   },
                  //   child: Container(
                  //     width: 54,
                  //     height: 54,
                  //     decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //         image: AssetImage(
                  //           'assets/button_chat.png',
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 16,
                  // ),
                  Expanded(
                    child: Container(
                      height: 54,
                      child: TextButton(
                        onPressed: () {
                          cartProvider.addCart(widget.product);
                          Navigator.pushNamed(context, '/cart');
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: blueColor,
                        ),
                        child: Text(
                          'Add to Cart',
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}