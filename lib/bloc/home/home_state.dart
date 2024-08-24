import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageState extends HomeState{}

class ImageInitial extends ImageState {}

class ImageLoadInProgress extends ImageState {}

class ImageLoadSuccess extends ImageState {
  final String imagePath;

  ImageLoadSuccess(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class ImageLoadFailure extends ImageState {}


class RadioState extends HomeState{
  final List<bool> isSelected;

  RadioState(this.isSelected);

  @override
  List<Object> get props => [isSelected];
}

class AgreeState extends HomeState{
  final bool selectedValue;

  AgreeState(this.selectedValue);

  @override
  List<Object> get props => [selectedValue];
}

class RequestState extends HomeState{
  final String imgPath;
  final Uint8List? imgBytes;
  final String gender;
  final bool agreeYn;

  RequestState(this.imgPath,this.imgBytes,this.gender,this.agreeYn);

  @override
  List<Object> get props => [];

  // @override
  // List<Object> get props => [imgPath,gender,agreeYn];
}
