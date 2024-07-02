import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Onedaypage extends StatefulWidget {
  const Onedaypage({super.key});

  @override
  State<Onedaypage> createState() => _OnedaypageState();
}

class _OnedaypageState extends State<Onedaypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [Icon(Icons.menu)],
          ),
        ));
  }
}
