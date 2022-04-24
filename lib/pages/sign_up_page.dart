import 'package:flutter/material.dart';
import 'package:kantin/providers/auth_provider.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/loading_button.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController(text: '');

  TextEditingController usernameController = TextEditingController(text: '');

  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.register(
        name: nameController.text,
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redColor,
            content: Text(
              'Gagal Register!',
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
              'Sign Up',
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            ),
          ],
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama',
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
                controller: nameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Masukkan Nama',
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

    Widget usernameInput() {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
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
                controller: usernameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Masukkan Username',
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

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
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
                obscureText: true,
                controller: passwordController,
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

    Widget signupButton() {
      return Container(
        height: 44,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: ElevatedButton(
          child: Text(
            'Buat Akun Baru',
            style: blackTextStyle.copyWith(
              fontSize: 14,
              color: whiteColor,
            ),
          ),
          onPressed: handleSignUp,
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
        // child: TextButton(
        //   onPressed: handleSignUp,
        //   style: TextButton.styleFrom(
        //     backgroundColor: blueColor,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //   ),
        //   child: Text(
        //     'Sign Up',
        //     style: whiteTextStyle.copyWith(
        //       fontSize: 16,
        //       fontWeight: medium,
        //     ),
        //   ),
        // ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah punya akun? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign-in');
              },
              child: Text(
                'Masuk',
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
              nameInput(),
              usernameInput(),
              emailInput(),
              passwordInput(),
              isLoading ? LoadingButton() : signupButton(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
