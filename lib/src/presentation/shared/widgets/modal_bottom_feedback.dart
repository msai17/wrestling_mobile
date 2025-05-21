import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';

import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/core/utils/wrestling_copy_clipboard.dart';

class ModalBottomFeedback {

  final double height;

  const ModalBottomFeedback({
    this.height = 32
  });



  show(BuildContext context) {

    Widget cancelButton = TextButton(
      child: const Text("Закрыть", style: TextStyle(fontSize: 14,
          fontFamily: 'Crimson',
          color: AppColors.colorSmallText,
          fontWeight: FontWeight.normal),),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );

    showModalBottomSheet(
        backgroundColor: AppColors.colorBottomNav,
        context: context,
        builder: (builder) {
          return Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Обратная связь",style: TextStyle(fontFamily:'Crimson',fontWeight: FontWeight.w700,fontSize: 15,color: AppColors.colorSmallText)),
                    const SizedBox(height: 12),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        CopyClipBoard().copy(AppUrls.mailAmonlexa,'Почта скопировано');
                        Navigator.of(context).pop();
                      },
                      child: const Row(
                        children: [
                            Icon(Icons.mail,color: Colors.cyan),
                            SizedBox(width: 10),
                            Text(AppUrls.mailAmonlexa)
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => launchUrl(Uri.parse(AppUrls.telegramAmonlexa)),
                      child: const Row(
                        children: [
                          Icon(Icons.telegram_outlined,color: Colors.cyan),
                          SizedBox(width: 10),
                          Text("Техподдержка",style: TextStyle(fontFamily:'Crimson',fontWeight: FontWeight.w700,fontSize: 15,color: Colors.white),textAlign: TextAlign.center,),
                          ],
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        cancelButton,
                      ],
                    ),
                  ],
                ),
              )
          );
        });
  }


}