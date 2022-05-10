import 'package:flutter/material.dart';
import 'package:kantin/models/product_model.dart';
import 'package:kantin/pages/product_page.dart';
import 'package:kantin/providers/cart_provider.dart';
// import 'package:kantin/pages/product_page.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/currency_format.dart';
import 'package:provider/provider.dart';

class ProdukCard extends StatelessWidget {
  final ProductModel product;
  ProdukCard(this.product);

  String BaseUrl = 'http://103.183.75.223';

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                BaseUrl + product.galleries[0].url,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.name,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      color: greyColor,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    product.name,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    CurrencyFormat.convertToIdr(product.price, 0),
                    style: priceTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              child: ElevatedButton(
                child: Text(
                  'Add',
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                    color: whiteColor,
                  ),
                ),
                onPressed: () {
                  cartProvider.addCart(product);
                  Navigator.pushNamed(context, '/cart');
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: blueColor,
                  shadowColor: Colors.transparent,
                  // minimumSize: Size(210, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
