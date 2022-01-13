import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mecarassignment/controller/register/register_bloc.dart';
import 'package:mecarassignment/model/user.dart';
import 'package:mecarassignment/presentation/splash.dart';
import 'package:mecarassignment/utils/validation.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                  _getDialog(null, AppLocalizations.of(context)!.exist, () {
                    Navigator.pop(context);
                    context.read<RegisterBloc>().add(RegisterErrorPressed());
                  });
                }
                if (status == RegisterStatus.success) {
                  _getDialog(AppLocalizations.of(context)!.grat,
                      AppLocalizations.of(context)!.regissuccess, () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SplashScreen()));
                  });
                }
              },
              child: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 30),
                    //* REGISTER FORM
                    child: getRegisterForm(context),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Form getRegisterForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadLine(label: AppLocalizations.of(context)!.register),
          GetUserInput(
            controller: _emailController,
            hint: AppLocalizations.of(context)!.emailtextfield,
            isPassword: false,
            validator: Validation.emailValidation,
          ),
          GetUserInput(
            controller: _passwordController,
            hint: AppLocalizations.of(context)!.passwordtextfield,
            isPassword: true,
            validator: Validation.passwordValidation,
          ),
          GetUserInput(
            hint: AppLocalizations.of(context)!.confirmtextfield,
            isPassword: true,
            validator: (value) => value == _passwordController.text
                ? null
                : AppLocalizations.of(context)!.confirmerror,
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<RegisterBloc>().add(RegisterSubmmited(
                    _emailController.text, _passwordController.text));
              }
            },
            style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * .94, 65),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                backgroundColor: Colors.black,
                alignment: Alignment.center,
                primary: Colors.white,
                textStyle:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
            child: Text(AppLocalizations.of(context)!.register.toUpperCase()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 17),
                children: [
                  TextSpan(text: AppLocalizations.of(context)!.privacy1),
                  TextSpan(
                      text: AppLocalizations.of(context)!.privacy2,
                      style: const TextStyle(
                          decoration: TextDecoration.underline)),
                  TextSpan(text: AppLocalizations.of(context)!.privacy3),
                  TextSpan(
                      text: AppLocalizations.of(context)!.privacy4,
                      style: const TextStyle(
                          decoration: TextDecoration.underline)),
                ],
              ),
            ),
          )
        ],
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
        title: Text(label ?? AppLocalizations.of(context)!.error,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 25,
                color: Colors.black87,
                letterSpacing: 1.25,
                fontWeight: FontWeight.bold)),
        content: Text(content ?? AppLocalizations.of(context)!.stwr,
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
