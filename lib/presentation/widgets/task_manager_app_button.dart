import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/size_config.dart';
class AppButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF32D7E8), Color(0xFF44B4C1)],
        ),
        borderRadius: BorderRadius.circular(SizeConfig.width(context, 1)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Colors.transparent,
          disabledForegroundColor: Colors.transparent.withOpacity(0.38),
          disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context, 0.07),
            vertical: SizeConfig.width(context, 0.02),
          ),
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: SizeConfig.width(context, 0.04),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}