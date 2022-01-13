import 'package:flutter/material.dart';
import 'package:mecarassignment/presentation/discover.dart';
import 'package:mecarassignment/presentation/root.dart';

import 'global_widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadLine(
                label: 'Log in',
              ),
              const GetUserInput(
                //controller: _usernameController,
                hint: 'Email, Username or Phone number',
                isPassword: false,
                //validator: Validation.loginValidation,
              ),
              const GetUserInput(
                //controller: _passwordController,
                hint: 'Your account password',
                isPassword: true,
                //validator: Validation.loginValidation,
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RootScreen();
                  }));
                },
                style: TextButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * .94, 65),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: Colors.black,
                    alignment: Alignment.center,
                    primary: Colors.white,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 18)),
                child: const Text("LOG IN"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
