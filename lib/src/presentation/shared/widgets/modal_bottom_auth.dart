import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/src/presentation/auth/widgets/number_form_field.dart';

class ModalBottomAuth {

  final double height;
  final void Function(String) callback;

  const ModalBottomAuth({
    this.height = 32,
    required this.callback
  });



  show(BuildContext context) {
    final TextEditingController numberController = TextEditingController();
    Widget cancelButton = TextButton(
      child: const Text("Закрыть", style: TextStyle(fontSize: 14,
          fontFamily: 'Crimson',
          color: AppColors.colorSmallText,
          fontWeight: FontWeight.normal),),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );

    Widget sendButton = TextButton(
      child: const Text("Авторизоваться", style: TextStyle(fontSize: 14,
          fontFamily: 'Crimson',
          color: AppColors.colorSmallText,
          fontWeight: FontWeight.normal),),
      onPressed: () {
        callback(numberController.text);
      }
    );

    const noUnderlineStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 14, fontFamily: 'Crimson', color: AppColors.colorSmallText);


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
                    const Text("Авторизация",style: TextStyle(fontFamily:'Crimson',fontWeight: FontWeight.w700,fontSize: 15,color: AppColors.colorSmallText)),
                    const SizedBox(height: 12),
                    NumberFormField(
                        controller: numberController,
                        inputType: TextInputType.phone,
                        hintText: '+ (7999) 111-11-11',
                        maxLine: 1,
                        onChanged: (val) {
                        }
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'Нажимая кнопку “Далее”, я подтверждаю, что ознакомлен(а) с условием ', style: noUnderlineStyle,),
                          TextSpan(text: 'Политики конфиденциальности', style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14, fontFamily: 'Roboto', color: Color(0xff61697D), decoration: TextDecoration.underline), recognizer: TapGestureRecognizer()..onTap = ()=> launchUrl(Uri.parse(AppUrls.privacy))),
                          const TextSpan(text: ' и принимаю  условия', style: noUnderlineStyle),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        cancelButton,
                        sendButton
                      ],
                    ),
                  ],
                ),
              )
          );
        });
  }


}