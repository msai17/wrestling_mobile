import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';

class WrestlingSearchWidget extends StatelessWidget{

  final TextEditingController? controller;
  final ValueChanged<String> onPressSearch;
  final bool? autoShowKeyboard;


  const WrestlingSearchWidget({
    super.key,
    this.controller,
    required this.onPressSearch,
    this.autoShowKeyboard
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: <Widget> [
          Flexible(
            child: TextFormField(
            controller: controller,
            autofocus: autoShowKeyboard!,
            textAlign: TextAlign.start,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Roboto', fontSize: 13,),
            onChanged: (val) {
               controller!.text = val;
            },
              decoration: InputDecoration(
                counterText: '',
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                hintText: "Поиск", alignLabelWithHint: true ,hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Roboto', fontSize: 13,),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLength: 50,
            ),
          ),
          const SizedBox(width: 5),
          IconButton(onPressed: () {
            if(controller!.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Поле поиска не должен быть пустым',style: Theme.of(context).textTheme.titleMedium,)));
            }else{
              return onPressSearch(controller!.text);
            }
          }, icon: const Icon(Icons.search,color: AppColors.colorRed,size: 20)
          )
        ],
      ),
    );
  }
}