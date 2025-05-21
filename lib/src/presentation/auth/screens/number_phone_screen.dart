import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/number_phone/number_phone_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrestling_hub/src/presentation/auth/widgets/number_form_field.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_button.dart';

class NumberPhoneScreen extends StatefulWidget {

  const NumberPhoneScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NumberPhoneScreen();


}
class _NumberPhoneScreen extends State<NumberPhoneScreen>{

  final TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    numberController.text =  "+ 7";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const noUnderlineStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 14, fontFamily: 'Crimson', color: AppColors.colorSmallText);
    return BlocConsumer<NumberPhoneBloc, bool>(
    listener: (context, state) {
      state;
    },
    builder: (context, state) {
    return Scaffold(
     floatingActionButton: SizedBox(
         height: 40,
        width: 84,
        child: WrestlingButton(
            height: 40,
            titleWidget: const Text('Далее', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Crimson')),
            primaryColor: AppColors.colorRed,
            isFilled: state,
            onPressed: () {
              if(numberController.text.length > 15) {
                GoRouter.of(context).pushReplacementNamed(AppRoute.sms, pathParameters: {'number': numberController.text.toString()});
              }else{
                Fluttertoast.showToast(msg: 'Пожалуйста введите корректный номер');
              }
        })
     ),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const Text("Какой у тебя номер телефона?",style: TextStyle(fontFamily:'Crimson',fontWeight: FontWeight.bold,fontSize: 22)),
                  const SizedBox(height: 24),
                  NumberFormField(
                      controller: numberController,
                      inputType: TextInputType.phone,
                      hintText: '+ (9999) 111-11-11',
                      maxLine: 1,
                      onChanged: (val) {
                        context.read<NumberPhoneBloc>().add(NumberPhoneEvent(numberController.text));
                      }
                  ),
                  const SizedBox(height: 12),
                  const Text("Мы отправим вам текстовое сообщение с кодом подтверждения",style: TextStyle(fontFamily:'Crimson',fontWeight: FontWeight.normal,fontSize: 14,color: AppColors.colorSmallText)),
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
                  )
                ],
              ),
            )
        )
    );
  },
);
  }


}

