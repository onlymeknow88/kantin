import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantin/models/transaction_model.dart';
import 'package:kantin/pages/order_detail.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/custom_page_route.dart';
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
    DateTime date = widget.transaction.createdAt;
    String dateString =
        DateFormat('EEEE, d MMM yyyy HH:mm:ss', 'id_ID').format(date);

    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    selectOrder() async {
      await Provider.of<TransactionProvider>(context, listen: false)
          .getTransactions(authProvider.user.token);
      setState(() {
        // Navigator.of(context)
        //     .pushNamed('/order-list', arguments: widget.transaction.id);
        Navigator.of(context).push(
          CustomPageRoute(
            child: OrderDetailPage(widget.transaction),
          ),
        );
      });
    }

    return GestureDetector(
      // onTap: () {
      //   setState(() {
      //     Navigator.of(context).push(
      //       CustomPageRoute(
      //         child: OrderDetailPage(widget.transaction),
      //       ),
      //     );
      //   });
      // },
      onTap: () => selectOrder(),
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
                  dateString,
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
