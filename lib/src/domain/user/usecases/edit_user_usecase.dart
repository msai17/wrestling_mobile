import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/data/user/models/user.dart';
import 'package:wrestling_hub/src/domain/user/repository/user_repository.dart';
class EditUserUseCase implements UseCase<DataState<User>, Map<String,dynamic>> {

  EditUserUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<DataState<User>> call({void params}) {
    return _userRepository.editUser(params as Map<String,dynamic>);
  }

}