import 'package:flutter/material.dart';

class HitMeButton extends StatelessWidget {
  const HitMeButton({super.key, required this.text, required this.onPressed});

  final String text;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.red.shade700,
      splashColor: Colors.redAccent,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Text(
          text,
          maxLines: 1,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
