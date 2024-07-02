import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Color(0xffF7CBFD), Color(0xff7758D1)],
                center: Alignment.bottomCenter)),
      ),
    );
  }
}
