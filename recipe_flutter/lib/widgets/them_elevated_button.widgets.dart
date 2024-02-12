import 'package:flutter/material.dart';
import 'package:recipe_flutter/utilities/colors.dart';

class ThemeElevatedButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onPressedAction;
  const ThemeElevatedButton(
      {super.key, required this.buttonText, required this.onPressedAction});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedAction,
      child: Text(
        " ${buttonText}",
        style: TextStyle(color: ColorApp.whiteColor, fontSize: 20),
      ),
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: Size(300, 50),
          backgroundColor: ColorApp.mainColor),
    );
  }
}
