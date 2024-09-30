import 'package:flutter/material.dart';

class SuccessStoryPage extends StatefulWidget {
  const SuccessStoryPage({super.key});

  @override
  State<SuccessStoryPage> createState() => _SuccessStoryPageState();
}

class _SuccessStoryPageState extends State<SuccessStoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Column(children: [Text('The alumni having remarkable success in their career can add their success stories and may have it be shared as posts on the success stories page so everyone can read it.')],),),
    );
  }
}