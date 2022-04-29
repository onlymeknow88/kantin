import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantin/models/cart_model.dart';
import 'package:kantin/models/transaction_model.dart';
import 'package:kantin/pages/order_detail.dart';
import 'package:kantin/theme.dart';

class OrdersCard extends StatelessWidget {
  final TransactionModel transaction;
  OrdersCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    // DateTime date = transaction.createdAt;
    // String dateString = DateFormat('E, d MMM yyyy HH:mm:ss').format(date);
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/order-detail');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailPage(transaction),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: lightGrayColor,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID: #${transaction.id}',
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  // 'Status: ${transaction.status}',
                  '${transaction.items.length} items',
                  style: subtitleTextStyle,
                ),
              ],
            ),
            Container(
              height: 20,
              padding: EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: lightBlueColor,
              ),
              child: Text(
                transaction.status,
                // 'Pending',
                style: primaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
