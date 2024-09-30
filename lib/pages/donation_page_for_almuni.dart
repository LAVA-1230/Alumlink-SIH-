import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('On the donation page, there will be one donation portal from which the donation directly goes to the institute and the other thing is that the students currently studying in the institute can post or create different fundraisers program that shows up as posts and an alumni may donate to that as well. This may include requesting donation for any sports equipment for hostel, or anything else.'),),
    );
  }
}