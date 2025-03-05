import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/usecase.dart';
import 'package:wrestling_hub/src/data/main/models/comment.dart';
import 'package:wrestling_hub/src/domain/main/repository/main_repository.dart';


class SendNewsCommentUseCase implements UseCase<DataState<List<Comment>>, Map<String,String>> {
  SendNewsCommentUseCase(this._mainRepository);

  final MainRepository _mainRepository;

  @override
  Future<DataState<List<Comment>>> call({void params}) {
    return _mainRepository.sendCommentNews(params as Map<String,String>);
  }
}