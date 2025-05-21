import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/splash/splash_bloc.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/error_page.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    context.read<SplashBloc>().add(SplashGetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme;
     return Scaffold(
      backgroundColor: AppColors.colorBackground,
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoggedState) {
            context.goNamed(AppRoute.home);
          }
          if (state is SplashFirstLaunchState) {
            context.goNamed(AppRoute.onboard);
          }
        },
        builder: (context, state) {
          if(state is SplashFailedState) {
            return ErrorPage(
              errorText: state.message,
              onPress: () {
                context.read<SplashBloc>().add(SplashGetUserEvent());
              },
              icon: Icons.app_blocking_outlined,
              buttonText: 'Повторить',
            );
          }
          return SafeArea(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             mainAxisSize: MainAxisSize.max,
             children: [
               Center(
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(30),
                   child: Image.asset('assets/icons/wrestling_logo.png', height: 150, width: 150),
                 ),
               ),
               const SizedBox(height: 30),
               Text("Wrestling Hub",style: txtStyle.titleLarge,textAlign: TextAlign.center),
               const Text("for Amonlexa",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Crimson',color: Colors.white),textAlign: TextAlign.center),
             ],
           )
          );
          },
      )
    );
  }
}