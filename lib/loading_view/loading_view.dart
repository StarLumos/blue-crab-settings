import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:bluetooth_detector/styles/colors.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: LoadingAnimationWidget.fourRotatingDots(color: colors.foreground, size: 200));
  }
}
