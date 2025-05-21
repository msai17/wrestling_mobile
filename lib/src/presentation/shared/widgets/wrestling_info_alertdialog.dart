import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';

class WrestlingInfoAlertdialog extends StatelessWidget {

  final String title;
  final String description;
  final VoidCallback onClose;
  final Widget contentWidget;

  const WrestlingInfoAlertdialog({
    super.key,
    this.title = "",
    this.description = "",
    required this.onClose,
    required this.contentWidget,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      child: showAlertDialog(context),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget yesButton = TextButton(
      onPressed: onClose,
      child: Text("Хорошо",style: Theme.of(context).textTheme.titleSmall),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      alignment: Alignment.center,
      backgroundColor: AppColors.colorBackground,
      title: Container(alignment:Alignment.center,child: Text(title,style: Theme.of(context).textTheme.titleLarge)),
      content: contentWidget,
      actions: [
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}