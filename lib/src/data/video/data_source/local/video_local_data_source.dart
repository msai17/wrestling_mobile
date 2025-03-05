import 'package:hive_flutter/adapters.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';

abstract class VideoLocalDataSource {
  factory VideoLocalDataSource(Box<Video> boxVideos) = _VideoLocalDataSource;
  List<Video> getFavoriteVideos();
  void addFavorite(Video video);
  void deleteFavorite(Video video);
  bool isFavorite(Video video);
  void clear();
}
class _VideoLocalDataSource implements VideoLocalDataSource {

  final Box<Video> videoBox;


  _VideoLocalDataSource(this.videoBox);

  @override
  List<Video> getFavoriteVideos() {
    return videoBox.values.toList();
  }

  @override
  Future<void> addFavorite(Video video) async {
    await videoBox.put(video.id, video);
  }

  @override
  void deleteFavorite(Video video) async {
    await videoBox.delete(video.id);
  }

  @override
  bool isFavorite(Video video) {
    if(videoBox.get(video.id) != null) {
      return true;
    }
    return false;
  }

  @override
  void clear() {
    videoBox.clear();
  }


}