import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mecarassignment/presentation/discover.dart';

import 'global_widgets/widgets.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;
  final screen = [
    const DiscoverScreen(),
    const Center(
      child: Text(
        "Search Screen",
      ),
    ),
    const Center(
      child: Text("Add Screen"),
    ),
    const Center(
      child: Text("Chat Screen"),
    ),
    const Center(
      child: Text("Profile Screen"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 1,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          getNavItem("assets/icons/home.svg"),
          getNavItem("assets/icons/search.svg"),
          BottomNavigationBarItem(
            label: '',
            icon: SizedBox(
              height: 40,
              width: 75,
              child: Stack(
                children: [
                  RadiantGradientMask(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(45))),
                      height: 40,
                      width: 75,
                    ),
                  ),
                  const Center(
                    child: Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          getNavItem("assets/icons/chat.svg"),
          getNavItem("assets/icons/person.svg"),
        ],
      ),
    );
  }

  BottomNavigationBarItem getNavItem(String svgPath) {
    return BottomNavigationBarItem(
      label: '',
      icon: SvgPicture.asset(
        svgPath,
        color: Colors.black,
        width: 20,
        height: 20,
      ),
    );
  }
}
