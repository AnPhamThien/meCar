import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mecarassignment/controller/login/login_bloc.dart';
import 'package:mecarassignment/model/user.dart';
import 'package:mecarassignment/presentation/root.dart';
import 'package:mecarassignment/utils/validation.dart';

import 'global_widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
    required this.userList,
  }) : super(key: key);
  final List<User> userList;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isLogin = false;
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocProvider(
            create: (context) => LoginBloc(widget.userList),
            child: BlocListener<LoginBloc, LoginState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                final status = state.status;
                if (status == LoginStatus.submitting) {
                  _isLogin == true;
                }
                if (status == LoginStatus.failed) {
                  _getDialog(state.errorMessage, () {
                    Navigator.pop(context);
                    context.read<LoginBloc>().add(LoginErrorPressed());
                  });
                }
                if (status == LoginStatus.success) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const RootScreen()));
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HeadLine(
                              label: 'Log in',
                            ),
                            GetUserInput(
                              controller: _usernameController,
                              hint: 'Email, Username or Phone number',
                              isPassword: false,
                              validator: Validation.loginValidation,
                            ),
                            GetUserInput(
                              controller: _passwordController,
                              hint: 'Your account password',
                              isPassword: true,
                              validator: Validation.loginValidation,
                            ),
                            const SizedBox(height: 15),
                            AbsorbPointer(
                              absorbing: _isLogin,
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(
                                        LoginSubmmited(_usernameController.text,
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
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18)),
                                child: _isLogin
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text("Login"),
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _getDialog(String? content, void Function()? func) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actionsAlignment: MainAxisAlignment.center,
        title: const Text('Error !',
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
