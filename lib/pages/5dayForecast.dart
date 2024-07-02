import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class daysForecast extends StatelessWidget {
  const daysForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
      ),
    )
  }
}
