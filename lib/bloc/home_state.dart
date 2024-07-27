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
  final String selectedValue;

  RadioState(this.selectedValue);

  @override
  List<Object> get props => [selectedValue];
}

class AgreeState extends HomeState{
  final bool selectedValue;

  AgreeState(this.selectedValue);

  @override
  List<Object> get props => [selectedValue];
}