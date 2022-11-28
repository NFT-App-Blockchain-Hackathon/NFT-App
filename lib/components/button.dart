import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Button extends StatelessWidget {
  const Button({required this.height, required this.tapFunction, required this.title});
  final double height;
  final String title;
  final GestureTapCallback tapFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapFunction,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
