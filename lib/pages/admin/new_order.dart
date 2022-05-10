import 'package:flutter/material.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/new_order_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewOrderPage extends StatefulWidget {
  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  void initState() {
    // TODO: implement initState
    getTransactionByStatus();
    super.initState();
  }

  Future<void> getTransactionByStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    await Provider.of<TransactionProvider>(context, listen: false)
        .getTransactionsByStatus(token);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    transactionProvider.getTransactionsByStatus(authProvider.user.token);

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
            Navigator.pop(context);
          },
        ),
        title: Text(
          'New Order',
          style: TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
      );
    }

    Widget content() {
      return RefreshIndicator(
        onRefresh: getTransactionByStatus,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: ListView(
            children: transactionProvider.transactionbystatus
                .map(
                  (transaction) => NewOrderCard(transaction),
                )
                .toList(),
          ),
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
