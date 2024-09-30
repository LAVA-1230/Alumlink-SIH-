import 'package:flutter/material.dart';

class Eventspage extends StatefulWidget {
  const Eventspage({super.key});

  @override
  State<Eventspage> createState() => _EventspageState();
}

class _EventspageState extends State<Eventspage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Column(children: [Text('On the events page, the posts of  ongoing events and upcoming events will show up.')],),),);
  }
}