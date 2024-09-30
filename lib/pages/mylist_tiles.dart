import 'package:flutter/material.dart';

class MylistTiles extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const MylistTiles({super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        leading: Icon(icon,color:Colors.white),
        onTap: onTap,
        title: Text(text,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}