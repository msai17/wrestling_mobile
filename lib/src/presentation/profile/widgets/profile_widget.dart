import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/show_image.dart';


class ProfileWidget extends StatelessWidget {

  final String? avatar;
  final double height;
  final double width;

  const ProfileWidget({super.key, this.avatar, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: AppColors.colorRed, width: 1),
          borderRadius: BorderRadius.circular(90),
        ),
      child: avatar!.isEmpty ? Icon(Icons.account_circle_outlined, color: Colors.white, size: height) : ShowImage(image: avatar!, width: width, circular: 90,height: height,isCard: false,)
    );
  }
}