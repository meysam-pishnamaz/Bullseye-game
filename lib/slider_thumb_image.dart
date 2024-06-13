import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class SliderThumbImage extends SliderComponentShape {
  SliderThumbImage(this.image);
  final ui.Image? image;
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(0, 0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required ui.TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required ui.Size sizeWithOverflow}) {
    final ThumbImage = image;
    if (ThumbImage != null) {
      final Canvas = context.canvas;
      final imageOffset = Offset(
        center.dx - (ThumbImage.width / 2),
        center.dy - (ThumbImage.height / 2),
      );
      var paint = Paint();
      paint.filterQuality = FilterQuality.high;
      Canvas.drawImage(ThumbImage, imageOffset, paint);
    }
  }
}
