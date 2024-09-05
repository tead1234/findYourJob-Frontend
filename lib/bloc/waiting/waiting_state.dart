import 'package:equatable/equatable.dart';
import 'package:kwansang/data/models/result_response_dto.dart';

abstract class WaitingState extends Equatable {
  @override
  List<Object> get props => [];
}

class WaitingInitial extends WaitingState {}

class FileUploadErrorState extends WaitingState{}

class FileUploadAndEstimateSuccessState extends WaitingState{
  ResultResponseDto resultResponseDto;
  String imgPath;

  FileUploadAndEstimateSuccessState(this.resultResponseDto,this.imgPath);
}