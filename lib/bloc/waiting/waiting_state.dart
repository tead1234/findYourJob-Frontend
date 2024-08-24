import 'package:equatable/equatable.dart';

abstract class WaitingState extends Equatable {
  @override
  List<Object> get props => [];
}

class WaitingInitial extends WaitingState {}

class FileUploadErrorState extends WaitingState{}