import 'package:flutter/material.dart';
import 'package:kantin/models/user_model.dart';
import 'package:kantin/pages/admin/home_admin.dart';
import 'package:kantin/pages/get_started.dart';
import 'package:kantin/pages/home/main_page.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/category_provider.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void initState() {
    // TODO: implement initState
    autoLogin();
    super.initState();
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String email = prefs.getString('email');
    String password = prefs.getString('password');
    String roles = prefs.getString('roles');

    if (token != null) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);

      if (await authProvider.autologin(
        token: token,
        email: email,
        password: password,
      )) {
        await Provider.of<ProductProvider>(context, listen: false)
            .getProducts();
        await Provider.of<TransactionProvider>(context, listen: false)
            .getTransactions(token);
        await Provider.of<CategoryProvider>(context, listen: false)
            .getCategory();
        await Provider.of<TransactionProvider>(context, listen: false)
            .getTransactionsByStatus(token);
        await Provider.of<TransactionProvider>(context, listen: false)
            .getHistoryOrder(token);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MainPage(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redColor,
            content: Text(
              'Gagal Login!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => GetStartedPage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Container(
          // width: 130,
          // height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/logo.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
