import 'package:flutter/material.dart';

class APage extends StatelessWidget {
  const APage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('A'),),
    );
  }
}

class BPage extends StatelessWidget {
  const BPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('B'),),
    );
  }
}
