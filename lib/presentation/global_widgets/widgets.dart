import 'package:flutter/material.dart';

class GetUserInput extends StatelessWidget {
  const GetUserInput({
    Key? key,
    this.hint,
    this.isPassword,
    this.onChangeFunction,
    this.validator,
    this.controller,
  }) : super(key: key);
  final String? hint;
  final bool? isPassword;
  final Function(String?)? onChangeFunction;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChangeFunction,
        obscureText: isPassword ?? false,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}

class HeadLine extends StatelessWidget {
  const HeadLine({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 45,
          fontFamily: "Comfortaa",
        ),
      ),
    );
  }
}

class UserHeadLine extends StatelessWidget {
  const UserHeadLine({
    Key? key,
    this.username,
    this.userRealName,
    this.imgPath,
  }) : super(key: key);
  final String? username;
  final String? userRealName;
  final String? imgPath;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: ClipOval(
        child: Image(
          height: 45.0,
          width: 45.0,
          image: AssetImage(imgPath ?? "assets/images/avatar.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        username ?? "Thien An",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(userRealName ?? '@Thieen_aan'),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  const RadiantGradientMask({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 1],
        colors: [
          Color(0xffFF00D6),
          Color(0xffFF4D00),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
