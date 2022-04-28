import 'package:flutter/material.dart';
import 'package:kantin/pages/home/akun_page.dart';
import 'package:kantin/pages/home/home_page.dart';
import 'package:kantin/pages/home/order_list_page.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/page_provider.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:kantin/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  void initState() {
    // TODO: implement initState

    getTransaksi();
    super.initState();
  }

  getTransaksi() async {
    await Provider.of<TransactionProvider>(context, listen: false)
        .getTransactions(
            Provider.of<AuthProvider>(context, listen: false).user.token);
  }

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget customNavBar() {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: pageProvider.currentIndex,
        onTap: (value) {
          pageProvider.currentIndex = value;
        },
        backgroundColor: whiteColor,
        selectedItemColor: blackColor,
        unselectedItemColor: greyColor,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(
                bottom: 4,
              ),
              child: ImageIcon(
                AssetImage(
                  'assets/icon_home.png',
                ),
                size: 24,
                color: pageProvider.currentIndex == 0 ? blackColor : greyColor,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(
                bottom: 4,
              ),
              child: ImageIcon(
                AssetImage('assets/icon_order.png'),
                size: 24,
                color: pageProvider.currentIndex == 1 ? blackColor : greyColor,
              ),
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(
                bottom: 4,
              ),
              child: ImageIcon(
                AssetImage('assets/icon_user.png'),
                size: 24,
                color: pageProvider.currentIndex == 2 ? blackColor : greyColor,
              ),
            ),
            label: 'Akun',
          ),
        ],
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return HomePage();
          break;
        case 1:
          return OrderListPage();
          break;
        case 2:
          return AkunPage();
          break;

        default:
          return HomePage();
      }
    }

    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: customNavBar(),
      body: body(),
    );
  }
}
