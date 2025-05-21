import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';


class ShowImage extends StatelessWidget {

  final String? image;
  final double height;
  final double width;
  final double? opacity;
  final double circular;
  final bool? isCard;


  const ShowImage({super.key, required this.image, required this.height,required this.width, required this.circular,this.opacity = 1,this.isCard});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity!,
      child: CachedNetworkImage(
        color: Colors.white12,
        fit: BoxFit.cover,
        height: height,
        width: width,
        fadeInDuration: const Duration(milliseconds: 500),
        imageUrl: image != null ? '$image' : '',
        imageBuilder: (context, url) => Container(
          height: height,
          width: width, // Добавлено для обеспечения размеров
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(circular),
            image: DecorationImage(
              image: url,
              fit: isCard! ? BoxFit.cover : BoxFit.contain, // Оставляем как есть
            ),
          ),
        ),
        placeholder: (context, url) => Icon(Icons.downloading_outlined, size: height, color: AppColors.colorRed),
        errorWidget: (context, url, error) => Icon(Icons.error, size: height, color: AppColors.colorRed),
      ),
    );
  }

  Widget errorImage() {
    return Container(
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(circular),
          image: const DecorationImage(
              image: AssetImage('assets/images/wrestling_logo.png'),
              fit: BoxFit.cover
          )
      ),
    );
  }



}