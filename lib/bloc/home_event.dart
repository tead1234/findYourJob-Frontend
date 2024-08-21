import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ImagePicked extends HomeEvent {

}

class RadioClicked extends HomeEvent{
  final String selectedValue;

  RadioClicked(this.selectedValue);
}

class AgreeCheckClicked extends HomeEvent{
  final bool selectedValue;

  AgreeCheckClicked(this.selectedValue);
}
