import 'dart:io';
import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/domain/user/repository/user_repository.dart';
class SendImageServerUseCase implements UseCase<DataState<String>, String> {

  SendImageServerUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<DataState<String>> call({void params}) {
    return _userRepository.sendImageServer(params as File);
  }

}