import 'dart:io';

import 'package:flutter/material.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ImageSelected extends HomeState {
  final File image;

  ImageSelected({required this.image});
}

class ImageRemoved extends HomeState {
  final File image;

  ImageRemoved({required this.image});
}

class ImageLoading extends HomeState {
  final bool loading;

  ImageLoading({required this.loading});
}

class ImageLoaded extends HomeState {
  final bool loaded;

  ImageLoaded({required this.loaded});
}
