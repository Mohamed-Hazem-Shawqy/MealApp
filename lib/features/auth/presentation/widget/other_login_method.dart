import 'package:flutter/material.dart';

class OtherLoginMethod extends StatelessWidget {
  const OtherLoginMethod({super.key, this.onGoogleTap, this.onFacebookTap});
  final void Function()? onGoogleTap;
  final void Function()? onFacebookTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: onFacebookTap,
          child: Stack(
            children: [
              Image.asset('assets/images/Ellipse 9.png'),
              Positioned(
                top: 17,
                left: 17,
                child: Image.asset('assets/images/Facebook F.png'),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onGoogleTap,
          child: Stack(
            children: [
              Image.asset('assets/images/Ellipse 11.png'),
              Positioned(
                top: 12,
                left: 12,
                child: Image.asset('assets/images/Google.png', scale: 3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
