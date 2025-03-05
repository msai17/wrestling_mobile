import 'package:flutter/material.dart';

class WrestlingButton extends StatelessWidget {

  final String title;
  final Widget titleWidget;
  final VoidCallback onPressed;
  final bool loading;
  final Color primaryColor;
  final bool active;
  final bool isFilled;
  final double height;
  final Color textColor;

  const WrestlingButton(
      {super.key, this.title = "",
        required this.onPressed,
        this.loading = false,
        this.primaryColor = Colors.black,
        this.titleWidget = const SizedBox(),
        this.active = true,
        this.height = 30,
        this.isFilled = false,
        this.textColor = Colors.white});



  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: height,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 0.0, color: Colors.transparent),
              elevation: 0.0,
              splashFactory: InkRipple.splashFactory,
              backgroundColor: isFilled ? primaryColor : const Color(0xff969696),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          onPressed: () {
            if (active) {
              return onPressed();
            }
          },
          child: loading
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
                  )),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Загрузка...",
                style: TextStyle(
                    color: isFilled ? Colors.white : primaryColor),
              ),
            ],
          )
              : titleWidget,
        ));
  }
}