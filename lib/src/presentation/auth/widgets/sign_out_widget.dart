import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleSignOutWidget extends StatelessWidget {

  final String title;
  final String iconPath;
  final VoidCallback onPressed;
  const GoogleSignOutWidget({super.key, required this.iconPath, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
   return ElevatedButton.icon(
     style: ElevatedButton.styleFrom(
       backgroundColor: Colors.white,
       foregroundColor: Colors.black87,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
       elevation: 2,
       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
     ),
     onPressed: () async {
       return onPressed ();
     },
     icon: Image.asset(iconPath, height: 20),
     label: Text(title,style: const TextStyle(fontFamily: 'Crimson',fontSize: 13,fontWeight: FontWeight.bold)),
   );
  }


}