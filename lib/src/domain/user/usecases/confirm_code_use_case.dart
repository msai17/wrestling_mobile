import 'package:wrestling_hub/core/resources/data_state_auth.dart';
import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/data/user/models/user.dart';
import 'package:wrestling_hub/src/domain/user/repository/user_repository.dart';

class ConfirmCodeUseCase implements UseCase<DataStateAuth<User>, Map<String,dynamic>> {

  final UserRepository _userRepository;

  ConfirmCodeUseCase(this._userRepository);

  @override
  Future<DataStateAuth<User>> call({void params}) {
    return _userRepository.confirmSmsCode(params as Map<String,dynamic>);
  }
}