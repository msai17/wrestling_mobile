import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSelectBloc extends Cubit<NumberPhoneEvent, bool> {

  AuthSelectBloc() : super(false);

  
  onChangeNumberPhone(String phone, Emitter<bool> emit) async {
    if(event.number.length > 15) {
      emit(true);
    }else{
      emit(false);
    }
  }

}

