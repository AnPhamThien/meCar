import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mecarassignment/controller/register/register_bloc.dart';
import 'package:mecarassignment/model/user.dart';
import 'package:mecarassignment/presentation/splash.dart';
import 'package:mecarassignment/utils/validation.dart';

import 'global_widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, required this.userList}) : super(key: key);
  final List<User> userList;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isRegister = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocProvider(
            create: (context) => RegisterBloc(widget.userList),
            child: BlocListener<RegisterBloc, RegisterState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                final status = state.status;
                if (status == RegisterStatus.submitting) {
                  _isRegister == true;
                }
                if (status == RegisterStatus.failed) {
                  _getDialog("ERROR!", state.errorMessage, () {
                    Navigator.pop(context);
                    context.read<RegisterBloc>().add(RegisterErrorPressed());
                  });
                }
                if (status == RegisterStatus.success) {
                  _getDialog("CONGRATS!", "Account Registered", () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SplashScreen()));
                  });
                }
              },
              child: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 30),
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
                            validator: (value) =>
                                value == _passwordController.text
                                    ? null
                                    : "Passwords do not match",
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<RegisterBloc>().add(
                                    RegisterSubmmited(_emailController.text,
                                        _passwordController.text));
                              }
                            },
                            style: TextButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * .94,
                                    65),
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                                children: [
                                  TextSpan(
                                      text:
                                          'By signing up, you agree to Photo’s '),
                                  TextSpan(
                                      text: 'Terms of Service',
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.underline)),
                                  TextSpan(text: ' and '),
                                  TextSpan(
                                      text: 'Privacy Policy.',
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.underline)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _getDialog(
      String? label, String? content, void Function()? func) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actionsAlignment: MainAxisAlignment.center,
        title: Text(label ?? 'Error !',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                color: Colors.black87,
                letterSpacing: 1.25,
                fontWeight: FontWeight.bold)),
        content: Text(content ?? 'Something went wrong',
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w600)),
        actions: <Widget>[
          TextButton(
            onPressed: func,
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
