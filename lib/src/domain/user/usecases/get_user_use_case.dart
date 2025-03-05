import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/data/user/models/user.dart';
import 'package:wrestling_hub/src/domain/user/repository/user_repository.dart';

class GetUserUseCase implements UseCase<DataState<User>,String> {

  final UserRepository _authRepository;

  GetUserUseCase(this._authRepository);

  @override
  Future<DataState<User>>call({void params}) {
    return _authRepository.getUser(params as String);
  }
}