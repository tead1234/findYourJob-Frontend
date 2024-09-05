import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kwansang/bloc/waiting/waiting_bloc.dart';
import 'package:kwansang/bloc/waiting/waiting_state.dart';
import 'package:kwansang/data/models/result_response_dto.dart';
import 'package:kwansang/screens/result_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WaitingScreen extends StatelessWidget {
  String imgPath;
  String gender;
  bool agreeYn;

  WaitingScreen(this.imgPath, this.gender, this.agreeYn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("관상"),
      ),
      body: Stack(children: [
        BlocListener<WaitingBloc, WaitingState>(
          listenWhen: (previousState, state) {
            return true;
          },
          listener: (context, state) {
            if (state is WaitingInitial) {
              log("waiting init!!");
            } else if (state is FileUploadErrorState) {
              log("FileUploadErrorState!!");
              FToast()
                ..init(context)
                ..showToast(child: Text("Error Occurred", style: TextStyle(backgroundColor: Colors.grey,)));
            }else if (state is FileUploadAndEstimateSuccessState) {
              log("FileUploadAndEstimateSuccessState!!");
              Navigator.pushReplacement(
                  context,
                  _createRouteToResultScreen(state.resultResponseDto,state.imgPath));
            }
          },
          child: const SizedBox(),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearPercentIndicator(
                    width: 340.0,
                    lineHeight: 24.0,
                    percent: 0.78,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.redAccent,
                    animation: true,
                    animationDuration: 3000,
                    barRadius: Radius.circular(15),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),
                  AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('관상 서비스는 100% AI를 이용하여 판단합니다.',duration: Duration(milliseconds: 800),rotateOut: false),
                      RotateAnimatedText('재미로만 봐주세요.',duration: Duration(milliseconds: 800),rotateOut: false),
                      RotateAnimatedText('관상은 과학이 아닙니다.',duration: Duration(milliseconds: 800),rotateOut: false),
                      RotateAnimatedText('결과를 친구들과 공유해보세요.',duration: Duration(milliseconds: 800),rotateOut: false),
                      RotateAnimatedText('잠시 후 결과가 나옵니다..',duration: Duration(milliseconds: 800),rotateOut: false),
                    ],
                    repeatForever: true,

                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Route _createRouteToResultScreen(ResultResponseDto resultResponseDto, String imgPath) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ResultScreen(resultResponseDto,imgPath),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
