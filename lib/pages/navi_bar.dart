import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:google_nav_bar/google_nav_bar.dart";
import 'bottom_nav_controller.dart';
// import 'barscan.dart';

class NaviBar extends StatefulWidget {
  const NaviBar({super.key});

  @override
  State<NaviBar> createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
  @override
  Widget build(BuildContext context) {
    BottomNavContoller contoller = Get.put(BottomNavContoller());
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              padding: const EdgeInsets.all(16),
              onTabChange: (value) {
                contoller.index.value = value;
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.person_search_rounded,
                  text: "Jobs",
                ),
                GButton(
                  icon: Icons.supervised_user_circle_sharp,
                  text: "Profile",
                ),
              ]),
        ),
      ),
      body: Obx(
        () => contoller.pages[contoller.index.value],
      ),
    );
  }
}
