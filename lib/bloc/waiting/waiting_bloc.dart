

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwansang/bloc/waiting/waiting_event.dart';
import 'package:kwansang/bloc/waiting/waiting_state.dart';

import '../../repository/kwansang_api.dart';

class WaitingBloc extends Bloc<WaitingEvent, WaitingState> {
  final KwansangApi api;

  String imgPath = "";
  List<bool> isSelected = [false,false];
  bool agreeYn = false;

  WaitingBloc(KwansangApi this.api) : super(WaitingInitial()) {


    on<WaitingEvent>((event, emit) async {
      if (event is WaitingScreenInit) {
        log("screen init : upload start ");

        try {
          await api.uploadUserProfileImage(event.imgPath, event.imgBytes, event.gender, event.agreeYn);
        } on Exception catch (e) {
          log("catch error");
          emit(FileUploadErrorState());
        }
        log("screen init : upload after ");
      }

    });

  }


}