import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kantin/pages/add_produk.dart';
import 'package:kantin/pages/cart_page.dart';
import 'package:kantin/pages/category_feed.dart';
import 'package:kantin/pages/checkout_page.dart';
import 'package:kantin/pages/checkout_success_page.dart';
import 'package:kantin/pages/edit_profile.dart';
import 'package:kantin/pages/home/main_page.dart';
import 'package:kantin/pages/home/order_list_page.dart';
import 'package:kantin/pages/search_page.dart';
import 'package:kantin/pages/sign_in_page.dart';
import 'package:kantin/pages/sign_up_page.dart';
import 'package:kantin/pages/get_started.dart';
import 'package:kantin/pages/splash_screen.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/cart_provider.dart';
import 'package:kantin/providers/category_provider.dart';
import 'package:kantin/providers/page_provider.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(MyApp()));
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
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
        routes: {
          '/get-started': (context) => GetStartedPage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => MainPage(),
          '/edit-profile': (context) => EdtiProfilePage(),
          '/cart': (context) => CartPage(),
          '/order': (context) => OrderListPage(),
          '/search': (context) => SearchPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccessPage(),
          '/category-feed': (context) => CategoryFeedPage(),
          '/add-produk': (context) => AddProdukPage(),
        },
      ),
    );
  }
}
