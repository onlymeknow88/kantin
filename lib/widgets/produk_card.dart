import 'package:flutter/material.dart';
import 'package:kantin/models/product_model.dart';
// import 'package:kantin/pages/product_page.dart';
import 'package:kantin/theme.dart';

class ProdukCard extends StatelessWidget {
  // const ProdukCard({Key key, this.product}) : super(key: key);

  final ProductModel product;
  ProdukCard(this.product);

  String BaseUrl = 'http://103.183.75.223';

  // final ProductModel product;
  // ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: defaultMargin,
        right: defaultMargin,
        bottom: defaultMargin,
      ),
      decoration: BoxDecoration(),
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
                  '\Rp${product.price}',
                  style: priceTextStyle.copyWith(
                    fontWeight: medium,
                  ),
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: blueColor,
                shadowColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
