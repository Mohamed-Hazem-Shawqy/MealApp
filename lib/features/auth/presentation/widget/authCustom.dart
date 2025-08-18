import 'package:flutter/material.dart'; // Use Material instead of Cupertino

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.white, // Replace with appWhiteColor if defined
            thickness: 1,
            endIndent: 10,
          ),
        ),
        const Text(
          "or login with",
          style: TextStyle(
            color: Colors.white, // Replace with appWhiteColor if needed
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.white, // Replace with appWhiteColor if needed
            thickness: 1,
            indent: 10,
          ),
        ),
      ],
    );
  }
}
