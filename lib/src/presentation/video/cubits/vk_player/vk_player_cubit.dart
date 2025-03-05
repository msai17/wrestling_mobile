import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_hub/src/presentation/video/cubits/vk_player/vk_player_state.dart';

class VkPlayerCubit extends Cubit<VkPlayerState> {


  VkPlayerCubit() : super(VkPlayerInitState());


}