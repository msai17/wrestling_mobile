import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/domain/video/repository/video_repository.dart';

class AddFavoriteVideoUseCase implements UseCase<void, Video>{


  AddFavoriteVideoUseCase(this._videoRepository);

  final VideoRepository _videoRepository;

  @override
  Future<void> call({void params}) {
    return _videoRepository.addFavorite(params as Video);
  }
}