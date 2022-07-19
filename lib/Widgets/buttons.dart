
import 'package:flutter/material.dart';
import 'package:resume_demo/Utils/constants.dart';
import 'package:resume_demo/Utils/custom_widget.dart';

class SimpleOutlinedButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? color;
  final double? buttonHeight;
  final double? buttonWidth;
  final VoidCallback onPressed;
  final String text;

  const SimpleOutlinedButton({
    Key? key,
    this.backgroundColor,
    this.color,
    this.buttonHeight,
    this.buttonWidth,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: color,
          secondary: color,
        ),
      ),
      child: SizedBox(
        height: buttonHeight ?? 40,
        width: buttonWidth,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.green.shade50,
            onSurface: color != null ? color!.withOpacity(0.4) : null,
            side: BorderSide(width: 2.0, color: color ?? AppColor.primaryColor),
          ),
          child: CustomWidget.text(
            text,
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          )
        ),
      ),
    );
  }
}

class SimpleElevatedButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;

  final double? roundedRadius;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? elevation;
  final VoidCallback onPressed;
  final String text;

  const SimpleElevatedButton({
    Key? key,
    this.color,
    this.textColor,
    this.buttonHeight,
    this.buttonWidth,
    this.elevation,
    this.roundedRadius,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight ?? 40,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        child: CustomWidget.text(
          text,
          color: AppColor.primaryColor,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          fontSize: 18
        ),
        style: ElevatedButton.styleFrom(
          primary: color ?? Colors.green.shade50,
          shape: roundedRadius == null
              ? CustomWidget.roundedRectangleBorderAll(10)
              : CustomWidget.roundedRectangleBorderAll(roundedRadius!),
          shadowColor: Colors.black.withOpacity(0.5),
          elevation: elevation ?? 6,
        ),
      ),
    );
  }
}


