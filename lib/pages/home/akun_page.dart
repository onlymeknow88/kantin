import 'package:flutter/material.dart';
import 'package:kantin/models/user_model.dart';
import 'package:kantin/pages/admin/add_product.dart';
import 'package:kantin/pages/admin/list_product.dart';
import 'package:kantin/pages/admin/new_order.dart';
import 'package:kantin/pages/edit_profile.dart';
import 'package:kantin/pages/history_order.dart';
// import 'package:kantin/pages/home/home_page.dart';
import 'package:kantin/pages/home/order_list_page.dart';
import 'package:kantin/pages/sign_in_page.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/custom_page_route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunPage extends StatefulWidget {
  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  void initState() {
    // TODO: implement initState
    getProduct();
    super.initState();
  }

  getProduct() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    bool makeVisible = false;

    if (user.roles == 'ADMIN') {
      makeVisible = true;
    } else if (user.roles == 'USER') {
      makeVisible = false;
    }

    handleLogout() async {
      if (await authProvider.logout(
        token: user.token,
      )) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SignInPage(),
          ),
          (route) => false,
        );
      }
    }

    Widget header() {
      return AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(
              defaultMargin,
            ),
            child: Row(
              children: [
                ClipOval(
                  child: (user.profilePhotoUrl != null)
                      ? Image.asset(
                          'assets/default_profile.png',
                          width: 50,
                        )
                      : Image.network(
                          user.profilePhotoUrl,
                          width: 50,
                        ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hallo, ${user.name}',
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        '@${user.username}',
                        style: subtitleTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem(String text) {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: blackTextStyle.copyWith(fontSize: 13),
            ),
            Icon(
              Icons.chevron_right,
              color: blackColor,
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          decoration: BoxDecoration(
            color: whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Akun',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/edit-profile');
                  Navigator.of(context)
                      .push(CustomPageRoute(child: EdtiProfilePage()));
                },
                child: menuItem(
                  'Edit Profile',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(CustomPageRoute(child: HistoryOrderPage()));
                },
                child: menuItem(
                  'History Order',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: makeVisible,
                child: Text(
                  'Admin',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              Visibility(
                visible: makeVisible,
                child: GestureDetector(
                  onTap: () {
                    productProvider.getProducts();
                    Navigator.of(context)
                        .push(CustomPageRoute(child: ListPorductPage()));
                  },
                  child: menuItem(
                    'Add Product',
                  ),
                ),
              ),
              Visibility(
                visible: makeVisible,
                child: GestureDetector(
                  onTap: () {
                    productProvider.getProducts();
                    Navigator.of(context)
                        .push(CustomPageRoute(child: NewOrderPage()));
                  },
                  child: menuItem(
                    'New Order',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget bottom() {
      return Container(
        height: 44,
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
          vertical: defaultMargin,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: blueColor,
            width: 1,
          ),
        ),
        child: GestureDetector(
          onTap: handleLogout,
          child: Center(
            child: Text('Logout',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                )),
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        content(),
        bottom(),
      ],
    );
  }
}
