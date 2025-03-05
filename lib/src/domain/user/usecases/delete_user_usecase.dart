import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/domain/user/repository/user_repository.dart';

class DeleteUserUseCase implements UseCase<DataState<bool>, String> {

  DeleteUserUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<DataState<bool>> call({void params}) {
    return _userRepository.deleteUser(params as String);
  }

}