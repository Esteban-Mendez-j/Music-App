import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: CircularProgressIndicator(color: Color(0xFFFF4081)),
      ),
    );
  }
}
