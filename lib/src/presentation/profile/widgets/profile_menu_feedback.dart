import 'package:flutter/material.dart';

class ProfileMenuFeedback extends StatelessWidget {

  const ProfileMenuFeedback({
    super.key,
    required this.title,
    required this.onPress,
    required this.endIcon,
  });

  final String title;
  final VoidCallback onPress;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style:Theme.of(context).textTheme.labelSmall),
          endIcon ? const Icon(Icons.arrow_forward,color: Colors.white) : const SizedBox()
        ],
      ),
    );
  }


}