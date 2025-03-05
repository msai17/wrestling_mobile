import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/domain/main/repository/main_repository.dart';

class AddFavoriteNewsUseCase implements UseCase<void, News>{


  AddFavoriteNewsUseCase(this._mainRepository);

  final MainRepository _mainRepository;

  @override
  Future<void> call({void params}) {
    return _mainRepository.addFavorite(params as News);
  }
}