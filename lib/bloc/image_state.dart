import 'package:equatable/equatable.dart';

abstract class ImageState extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoadInProgress extends ImageState {}

class ImageLoadSuccess extends ImageState {
  final String imagePath;

  ImageLoadSuccess(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class ImageLoadFailure extends ImageState {}
