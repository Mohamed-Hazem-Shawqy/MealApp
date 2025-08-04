import 'package:flutter/material.dart';

class OtherLoginMethod extends StatelessWidget {
  const OtherLoginMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          children: [
            Image.asset('assets/images/Ellipse 9.png'),
            Positioned(
              top: 17,
              left: 17,
              child: Image.asset('assets/images/Facebook F.png'),
            ),
          ],
        ),
        Stack(
          children: [
            Image.asset('assets/images/Ellipse 11.png'),
            Positioned(
              top: 12,
              left: 12,
              child: Image.asset('assets/images/Google.png', scale: 3),
            ),
          ],
        ),
      ],
    );
  }
}
