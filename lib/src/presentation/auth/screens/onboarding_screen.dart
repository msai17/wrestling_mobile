import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/src/presentation/auth/widgets/onboarding_content_screen.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_data.dart';

class OnBoardingScreen extends StatefulWidget {

  const OnBoardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnBoardingScreen();

}

class _OnBoardingScreen extends State<OnBoardingScreen> {

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              children: const [
                OnBoardingContentScreen(
                    background: 'assets/images/frank_chamizo.jpeg',
                    title: 'Приветствие!',
                    description:'Добро пожаловать в Wrestling Hub!\nБудьте в курсе последних событий и наслаждайтесь захватывающими моментами мировой борьбы!\n'
                ),
                OnBoardingContentScreen(
                    background: 'assets/images/barroughz.jpeg',
                    title: 'О приложении',
                    description:'С приложением Wrestling Hub вы всегда будете в курсе последних новостей и событий мира вольной борьбы.\n\n Получайте актуальную информацию о турнирах, соревнованиях и достижениях спортсменов прямо на своем мобильном устройстве\n'
                        '\nОсновные функции приложения:\nНовости: самые свежие события и результаты соревнований, эксклюзивные материалы от ведущих экспертов.\n\nКомментарии: возможность обсудить важные моменты с другими пользователями и поделиться своим мнением.\n'
                        '\nВидео контент: смотрите повторы турниров, репортажи, интервью и многое другое в высоком качестве.'
                ),
                OnBoardingContentScreen(
                    background: 'assets/images/sadulaev.jpeg',
                    title: 'Для создания комфортной атмосферы общения в приложении Wrestling Hub, мы просим вас соблюдать следующие правила:',
                    description:'-Запрещено оскорблять других пользователей. Уважение к другим участникам сообщества является основой нашего взаимодействия.\n\n-Не провоцируйте межнациональные и межрелигиозные споры или конфликты. Мы ценим разнообразие мнений, но призываем вести дискуссии конструктивно и без агрессии.\n\n-Не отправляйте реферальные ссылки, рекламу и подобные сообщения. Наше сообщество создано для обсуждения спорта, а не для продвижения сторонних продуктов или услуг.\n\nВ случае нарушения этих правил администрация оставляет за собой право применить меры воздействия, включая временную блокировку аккаунта или постоянный бан. Мы стремимся поддерживать дружелюбное и уважительное общение внутри нашей платформы, поэтому призываем всех участников следовать установленным правилам.'
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: CustomizableEffect(
                        activeDotDecoration: DotDecoration(width: 20, height: 6, color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        dotDecoration: DotDecoration(borderRadius: BorderRadius.circular(30), width: 6, height: 6),
                      ),
                      onDotClicked: (index) => _controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn)
                  ),
                  IconButton(
                      onPressed: () {
                        if(_controller.page == 2) {
                          UserData.instance.setFirstLaunch();
                          context.go(AppRoute.home);
                        }else{
                          _controller.nextPage(duration: const Duration(milliseconds: 500), curve:  Curves.easeIn);
                        }
                      },
                      icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: AppColors.colorRed,
                          ),
                          child: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white)
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



}