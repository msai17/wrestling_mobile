import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/data/video/models/category_video.dart';
import 'package:wrestling_hub/src/domain/video/repository/video_repository.dart';


class GetVideosUseCase implements UseCase<DataState<List<CategoryVideo>>, void>{


  GetVideosUseCase(this._videoRepository);

  final VideoRepository _videoRepository;

  @override
  Future<DataState<List<CategoryVideo>>> call({void params}) {
    return _videoRepository.getVideos();
  }
}