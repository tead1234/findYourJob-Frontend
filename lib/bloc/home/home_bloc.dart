import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kwansang/repository/kwansang_api.dart';
import './home_event.dart';
import './home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ImagePicker _imagePicker = ImagePicker();
  final KwansangApi api;

  String imgPath = "";
  Uint8List? imgBytes;
  List<bool> isSelected = [false,false];
  bool agreeYn = false;

  HomeBloc(KwansangApi this.api) : super(ImageInitial()) {


    on<HomeEvent>((event, emit) async {
      if (event is ImagePicked) {
        emit(ImageLoadInProgress());
        try {
          final pickedFile = await _imagePicker.pickImage(
              source: ImageSource.gallery);
          if (pickedFile != null) {
            imgPath = pickedFile.path;
            imgBytes = await pickedFile.readAsBytes();
            emit(ImageLoadSuccess(pickedFile.path));
          } else {
            emit(ImageLoadFailure());
          }
        } catch (e) {
          emit(ImageLoadFailure());
        }
      } else if (event is RadioClicked) {
        if(event.selectedValue ==0){
          isSelected = [true,false];
        }else{
          isSelected = [false,true];
        }
        emit(RadioState(isSelected));
      } else if (event is AgreeCheckClicked) {
        emit(AgreeState(event.selectedValue));
      } else if (event is RequestClicked) {
        log("Request event !");
        if(imgPath.isEmpty || !isSelected.any((e)=>e)){ //이미지 경로가 없거나, 성별 선택안된 경우 일단 리턴
          log("입력값 체크 리턴");
          return;
        }
        var gender = isSelected[0] ? "men":"women";
        emit(RequestState(imgPath, imgBytes, gender, agreeYn));
        emit(ImageInitial());
      }

    });

  }


}
