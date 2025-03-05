import 'dart:io';
import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/src/data/user/models/user.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_data.dart';
import 'package:wrestling_hub/src/domain/user/usecases/delete_user_usecase.dart';
import 'package:wrestling_hub/src/domain/user/usecases/edit_user_usecase.dart';
import 'package:wrestling_hub/src/domain/user/usecases/get_local_user_usecase.dart';
import 'package:wrestling_hub/src/domain/user/usecases/send_image_server_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';



part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {

  EditUserUseCase _editProfileUseCase;
  SendImageServerUseCase _sendImageServerUseCase;
  DeleteUserUseCase _deleteProfileUseCase;
  GetLocalUserUseCase _getLocalUserUseCase;
  final Logger _logger;
  final UserData _userData;


  File? image;
  String uploadedImage = '';
  bool isSelectedImage = false;

  EditBloc(this._editProfileUseCase,
      this._sendImageServerUseCase,
      this._deleteProfileUseCase,
      this._getLocalUserUseCase,
      this._logger,
      this._userData) : super(EditInitialState()) {
    on<EditSelectImageEvent>(_onSelectImage);
    on<EditGetLocalEvent>(_onGetLocalUser);
    on<EditProfileEvent>(_onEditProfile);
    on<EditDeleteProfileEvent>(_onDeleteUser);
  }

  _onGetLocalUser(EditGetLocalEvent event, Emitter<EditState> emit) async {
    final dataState = await _getLocalUserUseCase();

    print('loca');

    if (dataState is DataFailed) {
       emit(EditFailedState(message: "Произошла ошибка при получении пользователя"));
    }

    if(dataState is DataSuccess) {
      emit(EditLocalUserState(user: dataState.data!, image: null));
    }

  }
  _onDeleteUser(EditDeleteProfileEvent event, Emitter<EditState> emit) async {
    GoRouter.of(event.context).pop(true);
    emit(EditLoadingState());

    final dataState = await _deleteProfileUseCase(params: _userData.getAccessToken());

    _logger.log(Logger.level, dataState.data);

    if (dataState is DataFailed) {
      _logger.log(Logger.level, "Failed");
      emit(EditFailedState(message: "Не удалось удалить профиль"));
    }
    if (dataState is DataSuccess) {
      _logger.log(Logger.level, "Success");
      emit(EditSuccessState(message: 'Профиль удален'));
    }
  }

  _onSelectImage(EditSelectImageEvent event, Emitter<EditState> emit) async {
    emit(EditLoadingState());
    final returnImage = await ImagePicker().pickImage(
        source: event.isCamera ? ImageSource.camera : ImageSource.gallery,
        maxHeight: 1024,
        maxWidth: 1024);
    if (returnImage != null) {
      image = File(returnImage.path);
      isSelectedImage = true;
      emit(EditLocalUserState(image: File(image!.path), user: _userData.currentUser!));
      if (event.context.mounted) {
        Navigator.of(event.context).pop();
      }
    }
  }

  _onEditProfile(EditProfileEvent event, Emitter<EditState> emit) async {
    emit(EditLoadingState());
    if (isSelectedImage) {
      print('123');
      final dataStateImage = await _sendImageServerUseCase(params: image!);
      if (dataStateImage is DataFailed) {
        Fluttertoast.showToast(msg: 'При загрузке фото произошла ошибка');
      }
      if (dataStateImage is DataSuccess) {
        uploadedImage = dataStateImage.data!;
      }
    }

    var avatar = uploadedImage.isEmpty ? _userData.currentUser!.avatars : uploadedImage;

    Map<String, dynamic> data = {
      "token": _userData.getAccessToken(),
      "first_name": event.firstName,
      "last_name": event.lastName,
      "patronymic": event.patronymic,
      "avatars": avatar,
      "mail": "",
    };

    final dataState = await _editProfileUseCase(params: data);

    if (dataState is DataFailed) {
      emit(EditFailedState(message: dataState.error.toString()));
    }

    if (dataState is DataSuccess) {
      UserData.instance.currentUser = dataState.data;
      emit(EditSuccessState(message: 'Профиль успешно обновлен'));
    }
  }
}
