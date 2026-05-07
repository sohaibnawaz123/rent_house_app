import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';


class ContentShader extends StatelessWidget {
  final Widget child;
  const ContentShader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => AppColor.iconBgGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );
  }
}
