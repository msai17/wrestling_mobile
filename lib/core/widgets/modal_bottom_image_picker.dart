import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/constants.dart';

class ModalBottomImagePicker {

  final VoidCallback onPressGallery;
  final VoidCallback onPressCamera;

  const ModalBottomImagePicker( {
        required this.onPressCamera,
        required this.onPressGallery,
    });


  void show(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: WrestlingColors.color_bottom_nav,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: onPressGallery,
                      child: const SizedBox (
                        child: Column (
                          children: [
                            Icon(Icons.image_search_sharp, size: 70,color: WrestlingColors.color_red), Text('Библиотека',style: TextStyle(fontFamily: 'Crimson',fontSize: 15,color: WrestlingColors.color_red),)
                        ]
                      ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: onPressCamera,
                      child: const SizedBox (
                        child: Column (
                          children: [
                             Icon(CupertinoIcons.photo_camera, size: 70,color: WrestlingColors.color_red), Text('Камера',style: TextStyle(fontFamily: 'Crimson',fontSize: 15,color: WrestlingColors.color_red),)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

}