import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class WaitingEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class WaitingScreenInit extends WaitingEvent {
  final String imgPath;
  final Uint8List? imgBytes;
  final String gender;
  final bool agreeYn;

  WaitingScreenInit(this.imgPath,this.imgBytes,this.gender,this.agreeYn);
}