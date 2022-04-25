import 'package:flutter/material.dart';
import 'package:kantin/pages/add_produk.dart';
import 'package:kantin/pages/cart_page.dart';
import 'package:kantin/pages/checkout_success_page.dart';
import 'package:kantin/pages/edit_profile.dart';
import 'package:kantin/pages/home/main_page.dart';
import 'package:kantin/pages/home/order_list_page.dart';
import 'package:kantin/pages/order_detail.dart';
import 'package:kantin/pages/search_page.dart';
import 'package:kantin/pages/sign_in_page.dart';
import 'package:kantin/pages/sign_up_page.dart';
import 'package:kantin/pages/get_started.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => GetStartedPage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => MainPage(),
          '/edit-profile': (context) => EdtiProfilePage(),
          '/order': (context) => OrderListPage(),
          '/order-detail': (context) => OrderDetailPage(),
          '/search': (context) => SearchPage(),
          '/cart': (context) => CartPage(),
          '/checkoutsuccess': (context) => CheckoutSuccessPage(),
          '/add-produk': (context) => AddProdukPage(),
        },
      ),
    );
  }
}
