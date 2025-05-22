import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_resource.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/number_phone/number_phone_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrestling_hub/src/presentation/auth/widgets/sign_out_widget.dart';
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
    const noUnderlineStyle = TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14,
        fontFamily: 'Crimson',
        color: AppColors.colorSmallText);
    return BlocConsumer<NumberPhoneBloc, bool>(
      listener: (context, state) {
        state;
      },
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
                child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              const SizedBox(height: 80),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/icons/wrestling_logo.png',
                      height: 150, width: 150),
                ),
              ),
              const Text("Авторизация",
                  style: TextStyle(
                      fontFamily: 'Crimson',
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
              NumberFormField(
                  controller: numberController,
                  inputType: TextInputType.phone,
                  hintText: '+ (9999) 111-11-11',
                  maxLine: 1,
                  onChanged: (val) {
                    context
                        .read<NumberPhoneBloc>()
                        .add(NumberPhoneEvent(numberController.text));
                  }),
              const Text(
                  "Мы отправим вам текстовое сообщение с кодом подтверждения",
                  style: TextStyle(
                      fontFamily: 'Crimson',
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: AppColors.colorWhite)),
              const Expanded(child: SizedBox()),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GoogleSignOutWidget(
                    title: 'Войти по Google',
                    iconPath: AppResources.iconGoogle,
                    onPressed: () {

                    }
                  ),
                  GoogleSignOutWidget(
                  title: 'Войти по Apple id',
                  iconPath: AppResources.iconApple,
                    onPressed: () {

                    },
                  ),
                ],
              ),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Нажимая кнопку “Далее”, я подтверждаю, что ознакомлен(а) с условием ',
                      style: noUnderlineStyle,
                    ),
                    TextSpan(
                        text: 'Политики конфиденциальности',
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            color: Color(0xff61697D),
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrl(Uri.parse(AppUrls.privacy))),
                    const TextSpan(
                        text: ' и принимаю  условия', style: noUnderlineStyle),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    height: 40,
                    width: 84,
                    alignment: Alignment.centerRight,
                    child: WrestlingButton(
                        height: 40,
                        titleWidget: const Text('Далее',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Crimson')),
                        primaryColor: AppColors.colorRed,
                        isFilled: state,
                        onPressed: () {
                          if (numberController.text.length > 15) {
                            GoRouter.of(context).pushReplacementNamed(
                                AppRoute.sms,
                                pathParameters: {
                                  'number': numberController.text.toString()
                                });
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Пожалуйста введите корректный номер');
                          }
                        })),
              ),
            ],
          ),
        )));
      },
    );
  }
}

