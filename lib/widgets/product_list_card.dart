import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kantin/models/product_model.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/currency_format.dart';
import 'package:provider/provider.dart';

class ProductListCard extends StatefulWidget {
  final ProductModel product;
  ProductListCard(this.product);

  @override
  State<ProductListCard> createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> {
  String BaseUrl = 'http://103.183.75.223';
  void initState() {
    // TODO: implement initState
    getProduct();
    super.initState();
  }

  Future<void> getProduct() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
  }

  Future<void> deleteProduct() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .deleteProducts(widget.product.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showDialogDelete() {
      return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text('Apakah anda yakin ingin menghapus produk?'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Tidak',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Ya',
                  style: primaryTextStyle.copyWith(
                    fontWeight: bold,
                  ),
                ),
                onPressed: deleteProduct,
              ),
            ],
          );
        },
      );
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              BaseUrl + widget.product.galleries[0].url,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  // 'Product Name',
                  widget.product.name,
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Product Description',
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  CurrencyFormat.convertToIdr(widget.product.price, 0),
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: blackColor,
                  size: 24,
                ),
                onPressed: showDialogDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
