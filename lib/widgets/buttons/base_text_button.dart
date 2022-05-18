import 'package:flutter/material.dart';
import 'package:hm_service/theme/app_colors.dart';


class BaseTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  final Color primary;
  final double height;
  final double? width;
  final double radius;
  final double fontSize;
  final Color? borderColor;
  final Color? txtColor;

  const BaseTextButton(
      {Key? key,
      required this.title,
      this.width,
      this.txtColor,
      this.onPress,
      this.primary = kPrimary,
      this.radius = 25,
      this.height = 45,
      this.borderColor,
      this.fontSize = 16})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPress,
        child: Text(title,
            style: TextStyle(fontSize: fontSize,color: txtColor??kWhite)),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                side: BorderSide(color: borderColor ?? primary, width: 1)),
            minimumSize: Size(width ?? double.infinity, height),
            padding: const EdgeInsets.all(6),
            primary: onPress == null?kGreyLight: primary,
            onPrimary: Colors.white.withOpacity(0.4)));
  }
}
