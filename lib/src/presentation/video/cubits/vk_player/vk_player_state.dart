import 'package:flutter/material.dart';

abstract class VkPlayerState {}

class VkPlayerInitState extends VkPlayerState {}
class VkPlayerLoadingState extends VkPlayerState {}
class VkPlayerPauseState extends VkPlayerState {}
class VkPlayerProcessState extends VkPlayerState {}