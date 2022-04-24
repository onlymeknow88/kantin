import 'package:flutter/material.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/loading_button.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignIn() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamed(context, '/home');
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

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/logo.png'),
              )),
            ),
            const SizedBox(height: 20),
            Text(
              'Login',
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: blackTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: lightGrayColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                ),
                controller: emailController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Masukkan Email',
                  hintStyle: subtitleTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: blackTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: lightGrayColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                ),
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration.collapsed(
                  hintText: 'Masukkan Password',
                  hintStyle: subtitleTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget signinButton() {
      return Container(
        height: 44,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: ElevatedButton(
          child: Text(
            'Login',
            style: blackTextStyle.copyWith(
              fontSize: 14,
              color: whiteColor,
            ),
          ),
          onPressed: handleSignIn,
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            primary: blueColor,
            shadowColor: Colors.transparent,
            // minimumSize: Size(210, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
      );
    }

    Widget forgetPass() {
      return Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Text(
                'Forget Password?',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya Akun? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign-up');
              },
              child: Text(
                'Daftar',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              emailInput(),
              passwordInput(),
              forgetPass(),
              isLoading ? LoadingButton() : signinButton(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
