import 'package:flutter/material.dart';
import 'package:mecarassignment/model/user.dart';
import 'package:mecarassignment/presentation/global_widgets/widgets.dart';
import 'package:mecarassignment/presentation/login.dart';
import 'package:mecarassignment/presentation/register.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/splash_background.jpg"),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: getBody(context),
      ),
    );
  }

  SafeArea getBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<User> userList = User.getUserList();
    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Text(
                  "MeCar",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: "Comfortaa",
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.0),
              child: UserHeadLine(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 0, 13, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //* Login Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen(userList: userList);
                      }));
                    },
                    style: TextButton.styleFrom(
                        fixedSize: Size(size.width * .45, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 2)),
                        backgroundColor: Colors.white,
                        alignment: Alignment.center,
                        primary: Colors.black,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16)),
                    child: const Text("LOG IN"),
                  ),
                  //* Register Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegisterScreen(
                          userList: userList,
                        );
                      }));
                    },
                    style: TextButton.styleFrom(
                        fixedSize: Size(size.width * .45, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.black,
                        alignment: Alignment.center,
                        primary: Colors.white,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16)),
                    child: const Text("REGISTER"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
