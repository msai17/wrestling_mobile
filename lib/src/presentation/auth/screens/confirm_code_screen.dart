import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/core/utils/wrestling_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/auth/auth_bloc.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/auth/auth_event.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/auth/auth_state.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/modal_bottom_feedback.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_button.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_progress_bar.dart';

class ConfirmSmsCode extends StatelessWidget {

  final String numberPhone;
  ConfirmSmsCode({super.key,required this.numberPhone});

  final _controllerSms = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      body: BlocListener<AuthBloc, AuthState> (
        bloc: context.read(),
         listener: (BuildContext context, AuthState state) {
           if (state is AuthWrongCodeState) {
              WrestlingSnackBar().show(context, "Код неверный");
              _controllerSms.clear();
           }
           if (state is AuthSuccessState) {
             GoRouter.of(context).pop('auth');
             Fluttertoast.showToast(msg: 'Вы успешно авторизованы');
           }
           },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(
                child: WrestlingProgressBar()
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Text("Перейдите в телеграм бот для получения кода",style: TextStyle(fontFamily:'Crimson',fontWeight: FontWeight.bold,fontSize: 22)),
                    const SizedBox(height: 12),
                    Pinput(
                      controller: _controllerSms,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      showCursor: true,
                      errorTextStyle: const TextStyle(fontSize: 14,fontFamily: 'Crimson', color: Colors.red,fontWeight: FontWeight.w500),
                      defaultPinTheme: PinTheme(
                          height: 56.0,
                          width: 48.0,
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: AppColors.colorBottomNav,
                              borderRadius: BorderRadius.circular(15),
                              border: state is AuthWrongCodeState ? Border.all(color: Colors.red, width: 1.0) : Border.all(color: const Color(0x24000000), width: 1.5)
                          )
                      ),
                      length: 4,
                    ),
                    const SizedBox(height: 24),
                    WrestlingButton(
                        height: 40,
                        titleWidget: const Text('Потвердить', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Crimson')),
                        primaryColor: AppColors.colorRed,
                        isFilled:  true,
                        onPressed: () {
                          if(_controllerSms.text.length < 3) {
                            Fluttertoast.showToast(msg: 'Введите код');
                          }else{
                            context.read<AuthBloc>().add(AuthConfirmEvent(numberPhone,_controllerSms.text));
                          }
                        }
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => launchUrl(Uri.parse(AppUrls.telegramBotAuth)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.telegram_outlined,color: Colors.cyan),
                          SizedBox(width: 10),
                          Text("Перейти к телеграм боту",style: TextStyle(fontFamily:'Crimson',fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      onTap: () {
                        const ModalBottomFeedback().show(context);
                      },
                      child: const Text("Нужна помощь?",style: TextStyle(fontFamily:'Crimson',fontWeight: FontWeight.normal,fontSize: 14,color: AppColors.colorSmallText)),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        context.goNamed(AppRoute.main);
                      },
                      child: const Text("Нету телеграма? пропустить",style: TextStyle(fontFamily:'Crimson',fontWeight: FontWeight.normal,fontSize: 14,color: AppColors.colorSmallText)),
                    )
                  ],
                ),
            ),
          );
          },
        ),
      )
    );
  }
}