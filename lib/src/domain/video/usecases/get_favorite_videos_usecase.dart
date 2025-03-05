import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/domain/video/repository/video_repository.dart';

class GetFavoriteVideosUseCase implements UseCase<List<Video>, void>{


  GetFavoriteVideosUseCase(this._videoRepository);

  final VideoRepository _videoRepository;

  @override
  Future<List<Video>> call({void params}) {
    return _videoRepository.getFavoriteVideos();
  }
}