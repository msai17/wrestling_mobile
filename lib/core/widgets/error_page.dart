import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/constants.dart';
import 'package:wrestling_hub/core/widgets/wrestling_button.dart';

class ErrorPage extends StatelessWidget {

  final String? errorText;
  final String? buttonText;
  final IconData? icon;
  final VoidCallback? onPress;

  const ErrorPage({super.key, required this.errorText, required this.onPress, required this.icon, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WrestlingColors.color_background,
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon ?? Icons.error_outline_sharp,color: WrestlingColors.color_red,size: 200),
                const SizedBox(height: 10),
                Text(errorText!,style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
            child: WrestlingButton(
                height: 45,
                titleWidget: Text(buttonText ?? 'Повторить', style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Crimson')),
                primaryColor: WrestlingColors.color_red,
                isFilled: true,
                onPressed: () {
                }
            ),
          ),
        ],
      ),
    );
  }


}