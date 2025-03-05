import 'package:flutter_bloc/flutter_bloc.dart';

class NumberPhoneBloc extends Bloc<NumberPhoneEvent, bool> {
  
  NumberPhoneBloc() : super(false) {
    on<NumberPhoneEvent>(_onChangeNumberPhone);
  }

  _onChangeNumberPhone(NumberPhoneEvent event, Emitter<bool> emit) async {
    if(event.number.length > 15) {
      emit(true);
    }else{
      emit(false);
    }
  }

}

 class NumberPhoneEvent {
  String number;

  NumberPhoneEvent(this.number);
}