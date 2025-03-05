import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CopyClipBoard {


  void copy(String copy, String message) async {
    try{
      await Clipboard.setData(ClipboardData(text: copy));
      showToast(message);
    }catch(e) {
      showToast("Что то пошло не так${e.toString()}");
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

}