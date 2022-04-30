import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantin/models/transaction_model.dart';
import 'package:kantin/pages/order_detail.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:provider/provider.dart';

class OrdersCard extends StatefulWidget {
  final TransactionModel transaction;
  OrdersCard(this.transaction);

  @override
  State<OrdersCard> createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  @override
  Widget build(BuildContext context) {
    // DateTime date = transaction.createdAt;
    // String dateString = DateFormat('E, d MMM yyyy HH:mm:ss').format(date);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    Provider.of<TransactionProvider>(context, listen: false)
        .getTransactions(authProvider.user.token);
    return GestureDetector(
      onTap: () {
        setState(() {});
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                OrderDetailPage(widget.transaction),
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
                  'Order ID: #${widget.transaction.id}',
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  '${widget.transaction.items.length} items',
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
                widget.transaction.status,
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
