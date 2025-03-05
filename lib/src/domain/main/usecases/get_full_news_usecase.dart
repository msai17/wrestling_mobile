import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/domain/main/repository/main_repository.dart';

class GetFullNewsUseCase implements UseCase<DataState<News>, String> {
  GetFullNewsUseCase(this._mainRepository);

  final MainRepository _mainRepository;

  @override
  Future<DataState<News>> call({void params}) {
    return _mainRepository.getFullNews(params as String);
  }
}