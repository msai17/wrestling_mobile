import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/domain/main/repository/main_repository.dart';

class DeleteFavoriteNewsUseCase implements UseCase<void, String>{


  DeleteFavoriteNewsUseCase(this._mainRepository);

  final MainRepository _mainRepository;

  @override
  Future<void> call({void params}) {
    return _mainRepository.deleteFavorite(params as String);
  }
}