import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';

class ProfileMenuItem extends StatelessWidget {

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    required this.endIcon,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                height: 35,
                width: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.colorBottomNav
                ),
                child: Icon(icon,size: 20,color: Colors.white),
              ),
              const SizedBox(width: 5),
              Text(title,style:Theme.of(context).textTheme.labelSmall,),
            ],
          ),
          endIcon ? const Icon(Icons.arrow_forward,color: Colors.white) : const SizedBox()
        ],
      ),
    );
  }


}