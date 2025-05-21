import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';
class WrestlingProgressBar extends StatelessWidget {

  final double? size;

  const WrestlingProgressBar({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: size ?? 0.5,
      child: const CircularProgressIndicator(color: AppColors.colorRed)
    );
  }

}