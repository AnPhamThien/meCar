import 'package:flutter/material.dart';
import 'package:mecarassignment/utils/validation.dart';

import 'global_widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeadLine(label: "Register"),
                GetUserInput(
                  controller: _emailController,
                  hint: 'Your email',
                  isPassword: false,
                  validator: Validation.emailValidation,
                ),
                GetUserInput(
                  controller: _passwordController,
                  hint: 'Your account password',
                  isPassword: true,
                  validator: Validation.loginValidation,
                ),
                GetUserInput(
                  hint: 'Confirm password',
                  isPassword: true,
                  validator: (value) => value == _passwordController.text
                      ? null
                      : "Passwords do not match",
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {},
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
                  child: const Text("SIGN UP"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 17),
                      children: [
                        TextSpan(text: 'By signing up, you agree to Photo’s '),
                        TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                                decoration: TextDecoration.underline)),
                        TextSpan(text: ' and '),
                        TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyle(
                                decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
