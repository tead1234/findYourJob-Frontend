import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwansang/screens/result_screen.dart';
import '../bloc/image_bloc.dart';
import '../bloc/image_event.dart';
import '../bloc/image_state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('관상 직업 알아보기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_circle, size: 100),
                    SizedBox(width: 30,),
                    Column(
                      children: [
                        BlocBuilder<ImageBloc, ImageState>(
                          builder: (context, state) {
                            if (state is ImageLoadInProgress) {
                              return CircularProgressIndicator();
                            } else if (state is ImageLoadSuccess) {
                              return Image.file(
                                File(state.imagePath),
                                height: 200,
                              );
                            } else if (state is ImageLoadFailure) {
                              return Text('이미지 불러오기에 실패했습니다.');
                            } else {
                              return ElevatedButton(
                                onPressed: () {
                                  context.read<ImageBloc>().add(ImagePicked());
                                },
                                child: Text('이미지 열기'),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        Text('성별 선택:'),
                      Row(
                        children: [
                          Radio<String>(
                            value: '남성',
                            groupValue: '',
                            onChanged: (value) {
                              // 성별 선택 이벤트 처리
                            },
                          ),
                          Text('남성'),
                          Radio<String>(
                            value: '여성',
                            groupValue: '',
                            onChanged: (value) {
                              // 성별 선택 이벤트 처리
                            },
                          ),
                          Text('여성'),
                        ],
                      ),

                      ],
                    ),

                  ],
                ),
                SizedBox(height: 24,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(280,50),
                  ),
                  onPressed: () {
                    Navigator.push(context, _createRoute());
                  },
                  child: Text('관상 직업 확인하기'),
                )
              ],
            ),

            Spacer(),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {
                    // 체크박스 상태 변경 처리
                  },
                ),
                Text('정보수집에 동의합니다.'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}