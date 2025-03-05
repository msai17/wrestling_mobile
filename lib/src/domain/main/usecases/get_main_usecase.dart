import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/data/main/models/main_model.dart';
import 'package:wrestling_hub/src/domain/main/repository/main_repository.dart';

class GetMainUseCase implements UseCase<DataState<MainModel>, String> {
  GetMainUseCase(this._mainRepository);

  final MainRepository _mainRepository;

  @override
  Future<DataState<MainModel>> call({void params}) {
    return _mainRepository.getMain(params as String);
  }
}