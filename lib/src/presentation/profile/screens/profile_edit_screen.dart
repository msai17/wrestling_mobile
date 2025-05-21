import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/core/utils/wrestling_snackbar.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/modal_bottom_image_picker.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/show_image.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_button.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_form_field.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_progress_bar.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_simple_alertdialog.dart';
import 'package:wrestling_hub/src/presentation/profile/blocs/edit/edit_bloc.dart';

class ProfileEditScreen extends StatelessWidget {
   const ProfileEditScreen({super.key});

  static final TextEditingController lastNameController = TextEditingController();
  static final TextEditingController firstNameController = TextEditingController();
  static final TextEditingController patronymicController = TextEditingController();

  void setFormData (String ln,String fn,String pt) {
    lastNameController.text = ln;
    firstNameController.text = fn;
    patronymicController.text = pt;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       centerTitle: true,
       automaticallyImplyLeading: false,
       title: Text('Редактировать профиль', style: Theme.of(context).textTheme.titleLarge),
       actions: [
         IconButton(
             onPressed: () {
                Navigator.of(context).pop();
             },
          icon: const Icon(CupertinoIcons.xmark,color: Colors.white,))
       ],
     ),
     body: BlocListener<EditBloc, EditState>(
       bloc: context.read(),
       listener: (context, state) {
         if(state is EditLocalUserState) {
           setFormData("${state.user.lastName}", "${state.user.firstName}", "${state.user.patronymic}");
         }
        if (state is EditFailedState) {
          WrestlingSnackBar().show(context, state.message);
        }
        if (state is EditSuccessState) {
          Fluttertoast.showToast(msg: state.message);
          GoRouter.of(context).pop(true);
        }
      },
      child: BlocBuilder<EditBloc, EditState>(
         bloc: context.read<EditBloc>()..add(EditGetLocalEvent()),
          builder: (context, state) {
           if (state is EditInitialState) {
           }
           if (state is EditLoadingState) {
             return const Center(
               child: WrestlingProgressBar(),
             );
           }
          return SafeArea(
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Scrollbar(
                 child: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                           child: state is EditLocalUserState ? Column(
                             children: [
                               if(state.image != null)
                                  Image.file(File(state.image!.path),fit: BoxFit.contain,height: 250,width: double.infinity),
                               if(state.image == null)
                                  ShowImage(image: state.user.avatars, width: double.infinity, height: 250, circular: 10, isCard: false)
                             ],
                           ) : const SizedBox()
                       ),
                       Padding(
                         padding: const EdgeInsets.all(12.0),
                         child: WrestlingButton(
                             height: 40,
                             titleWidget: const Text('Выбрать фото', style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Crimson')),
                             primaryColor: AppColors.colorBottomNav,
                             isFilled: true,
                             onPressed: () {
                               ModalBottomImagePicker(
                                   onPressCamera: () {
                                     context.read<EditBloc>().add(EditSelectImageEvent(context,true));
                                   },
                                   onPressGallery: () {
                                     context.read<EditBloc>().add(EditSelectImageEvent(context,false));
                                   }
                               ).show(context);
                             }
                         ),
                       ),
                       const SizedBox(height: 5),
                       state is EditLocalUserState ?
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Фамилия',style: Theme.of(context).textTheme.labelSmall),
                           WrestlingFormField(
                               controller: lastNameController,
                               inputType: TextInputType.name,
                               maxLength: 100,
                               onChanged: (val) {}
                           ),
                           const SizedBox(height: 12),
                           Text('Имя',style: Theme.of(context).textTheme.labelSmall),
                           const SizedBox(height: 5),
                           WrestlingFormField(
                               controller: firstNameController,
                               inputType: TextInputType.name,
                               maxLength: 100,
                               onChanged: (val) {}
                           ),
                           const SizedBox(height: 12),
                           Text('Отчество',style: Theme.of(context).textTheme.labelSmall),
                           const SizedBox(height: 5),
                           WrestlingFormField(
                               controller: patronymicController,
                               inputType: TextInputType.name,
                               maxLength: 100,
                               onChanged: (val) {}
                           ),
                         ],
                       ) : const SizedBox(),
                       Center(
                         child: TextButton(
                             onPressed: () {
                               WrestlingSimpleAlertDialog(
                                 title: 'Вы точно хотите удалить аккаунт ?',
                                 description: 'При удаление аккаунта ваши данные будут храниться до 90 дней потом восстановить возможности не будет.',
                                 onYesButton: () {
                                   context.read<EditBloc>().add(EditDeleteProfileEvent(context));
                                 },
                                 onNoButton: () {
                                   Navigator.of(context).pop();
                                 },
                               ).showAlertDialog(context);
                             },
                             child: const Text('Удалить аккаунт',style: TextStyle(fontSize: 13,color: Colors.red,fontWeight: FontWeight.bold))
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 6.0),
                         child: WrestlingButton(
                             height: 40,
                             titleWidget: const Text('Сохранить', style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Crimson')),
                             primaryColor: AppColors.colorRed,
                             isFilled: true,
                             onPressed: () {
                               if(firstNameController.text.isEmpty || lastNameController.text.isEmpty || patronymicController.text.isEmpty) {
                                 Fluttertoast.showToast(msg: 'Пожалуйста заполните все поля');
                               }else{
                                 context.read<EditBloc>().add(EditProfileEvent(firstNameController.text, lastNameController.text, patronymicController.text));
                               }
                             }
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           );
         }
     ),
    ),
   );
  }
}

