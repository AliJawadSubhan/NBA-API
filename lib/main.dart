import 'package:flutter/material.dart';
import 'package:nba/home_page.dart';

main() {
  runApp(const NBATEAMS());
}

class NBATEAMS extends StatelessWidget {
  const NBATEAMS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
