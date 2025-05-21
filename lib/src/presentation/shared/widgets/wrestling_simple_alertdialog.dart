import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';

class WrestlingSimpleAlertDialog extends StatelessWidget {

  final String title;
  final String description;
  final VoidCallback onYesButton;
  final VoidCallback onNoButton;

  const WrestlingSimpleAlertDialog({
    super.key,
    this.title = "",
    this.description = "",
    required this.onYesButton,
    required this.onNoButton,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      child: showAlertDialog(context),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      onPressed: onNoButton,
      child: Text("Нет",style: Theme.of(context).textTheme.titleSmall),
    );
    Widget yesButton = TextButton(
      onPressed: onYesButton,
      child: Text("Да",style: Theme.of(context).textTheme.titleSmall),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      alignment: Alignment.center,
      backgroundColor: AppColors.colorBackground,
      title: Container(alignment:Alignment.center,child: Text(title,style: Theme.of(context).textTheme.titleLarge)),
      content: Text(description,style: Theme.of(context).textTheme.titleMedium),
      actions: [
        cancelButton,
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


  void dismiss(BuildContext dialogContext) {
    Navigator.of(dialogContext).pop();
  }
}