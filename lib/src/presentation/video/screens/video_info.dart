 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/constants.dart';
import 'package:wrestling_hub/core/widgets/modal_bottom_feedback.dart';
import 'package:wrestling_hub/core/widgets/show_image.dart';
import 'package:wrestling_hub/core/widgets/wrestling_button.dart';

class VideoInfoScreen extends StatelessWidget {
  const VideoInfoScreen({super.key});


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('VK Video', style: Theme.of(context).textTheme.titleLarge),
        ),
        body:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShowImage(image: 'https://www.sostav.ru/images/news/2021/10/15/nlmb6mfz_md.png', width: double.infinity,height: 200, circular: 30,isCard: true),
                const SizedBox(height: 10),
                Text(
                  'Использование технологии VK для показа видео',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Мы используем технологию VK для воспроизведения видео в нашем приложении. Это позволяет нам обеспечивать высокое качество воспроизведения и стабильную работу видеоплеера.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Ваша статистика',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Обратите внимание, что ваша статистика просмотров и взаимодействий с видео не влияет на работу приложения и не передается третьим лицам. Мы уважаем вашу конфиденциальность и заботимся о защите ваших данных.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Нашли свое видео?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Мы используем технологии VK для показа видео, и это не нарушает правил платформы.\n\nВаша статистика просмотров в VK не влияет на работу проекта, а только помогает улучшить его и популяризировать вольную борьбу.\nЕсли вы против использования ваших материалов, пожалуйста, напишите в нашу поддержку.\n\nЭтот проект создан для популяризации вольной борьбы и развития спортивного сообщества.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                WrestlingButton(
                    height: 40,
                    titleWidget: Text('Написать в поддержку', style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Crimson')),
                    primaryColor: WrestlingColors.color_red,
                    isFilled: true,
                    onPressed: () async {
                      const ModalBottomFeedback().show(context);
                    }
                ),
              ],
            ),
          ),
        ),
      );
  }


}