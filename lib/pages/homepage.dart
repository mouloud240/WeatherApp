import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.png'), fit: BoxFit.fill),

          // gradient: LinearGradient
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Color(0xFF003366),
          //     Color(0xFF663399),
          //     Color(0xFFFF00FF),
          //   ],
          //   stops: [0.1, 0.9, 1.0],
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 350,
                width: 350,
                child: Image.asset("assets/weatherLogo.png")),
            Column(
              children: [
                Text(
                  "Weather",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      textStyle: TextStyle(color: Colors.white, fontSize: 53)),
                ),
                Text(
                  "ForeCast",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      textStyle:
                          TextStyle(color: Color(0xffDDB130), fontSize: 50)),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 304,
              height: 72,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xffDDB130))),
                  onPressed: () =>
                      {Navigator.of(context).pushNamed('5daysforecast')},
                  child: Text(
                    "Get start",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 30),
                        color: Color(0xff362A84)),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
