import 'package:flutter/material.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/theme.dart';
import 'package:provider/provider.dart';

class GetStartedPage extends StatefulWidget {
  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  void initState() {
    // TODO: implement initState

    gitInit();

    super.initState();
  }

  gitInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/image_getstarted.png',
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Kantin Online',
                  style: whiteTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Temukan dan coba berbagai \nmakanan & minuman dari sini.',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: light,
                  ),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/sign-in');
                  },
                  child: Container(
                    width: 220,
                    height: 55,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 80,
                    ),
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Center(
                        child: Text('Get Started',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ))),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
