import 'package:flutter/material.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/page_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/order_list_card.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatefulWidget {
  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    transactionProvider.getTransactions(authProvider.user.token);
    PageProvider pageProvider = Provider.of<PageProvider>(context);

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
            pageProvider.changePage(0);
          },
        ),
        title: Text(
          'Order List',
          style: TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: ListView(
          children: transactionProvider.transactions
              .map(
                (transaction) => OrdersCard(transaction),
              )
              .toList(),
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
