import 'package:flutter/material.dart';
import 'package:alumni_app_1/pages/mylist_tiles.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? OnSignOut;
  const MyDrawer({super.key, required this.onProfileTap, required this.OnSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            DrawerHeader(
              child: Icon(
            Icons.person,
            color: Colors.white,
            size: 64,
          )),
          MylistTiles(
            icon: Icons.home,
            text: 'H O M E',
            onTap: () => Navigator.pop(context),
          ),
          MylistTiles(
            icon: Icons.home,
            text: 'P R O F I L E',
            onTap: onProfileTap,
          ),
          ],),

          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MylistTiles(
              icon: Icons.home,
              text: 'S I G N O U T',
              onTap: OnSignOut,
            ),
          ),

        ],
      ),
    );
  }
}
