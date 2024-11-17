import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwansang/bloc/waiting/waiting_bloc.dart';
import 'package:kwansang/bloc/waiting/waiting_event.dart';
import 'package:kwansang/screens/waiting_screen.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../repository/kwansang_api.dart';
import '../widgets/WaveAnimationBackground.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('관상 직업 알아보기'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            BlocListener<HomeBloc, HomeState>(
              listenWhen: (previousState, state) {
                // return true/false to determine whether or not
                // to call listener with state
                log("???");
                return state is RequestState;
              },
              listener: (context, state) {
                if (state is RequestState) {
                  Navigator.push(
                      context,
                      _createRouteToLoadingScreen(state.imgPath, state.imgBytes,
                          state.gender, state.agreeYn));
                }
              },
              child: const SizedBox(),
            ),
            //WaveAnimationBackground(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'assets/kwansangimage.jpg',
                      width: 250,
                      //height: 300,
                      fit: BoxFit.contain,
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<HomeBloc, HomeState>(
                          buildWhen: (previousState, state) {
                            return state is ImageState;
                          },
                          builder: (context, state) {
                            if (state is ImageLoadInProgress) {
                              return SizedBox(
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.redAccent,
                                )),
                                height: 100.0,
                                width: 100.0,
                              );
                            } else if (state is ImageLoadSuccess) {
                              return kIsWeb
                                  ? Image.network(
                                      state.imagePath,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.file(
                                      File(state.imagePath),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    );
                            } else {
                              return Icon(Icons.account_circle, size: 100);
                            }
                          },
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            OutlinedButton(
                              child: Text("이미지 열기"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              onPressed: () {
                                context.read<HomeBloc>().add(ImagePicked());
                              },
                            ),
                            SizedBox(height: 10),
                            Text('성별 선택:'),
                            BlocBuilder<HomeBloc, HomeState>(
                              buildWhen: (previousState, state) {
                                return state is RadioState;
                              },
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    ToggleButtons(
                                      color: Colors.black.withOpacity(0.60),
                                      selectedColor: Colors.red,
                                      selectedBorderColor: Colors.red,
                                      fillColor: Colors.red.withOpacity(0.08),
                                      splashColor: Colors.red.withOpacity(0.12),
                                      hoverColor: Colors.red.withOpacity(0.04),
                                      borderRadius: BorderRadius.circular(4.0),
                                      isSelected: (state is RadioState)
                                          ? state.isSelected
                                          : [false, false],
                                      onPressed: (index) {
                                        context
                                            .read<HomeBloc>()
                                            .add(RadioClicked(index));
                                      },
                                      children: [
                                        Text('남성'),
                                        Text('여성'),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    OutlinedButton(
                      child: Text("관상 직업 확인하기"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        context.read<HomeBloc>().add(RequestClicked());
                      },
                    ),

                    // BlocBuilder<HomeBloc, HomeState>(
                    //   buildWhen: (previousState, state) {
                    //     return state is AdLoaded;
                    //   },
                    //   builder: (context, state) {
                    //     if (state is AdLoaded) {
                    //       return Align(
                    //         alignment: Alignment.topCenter,
                    //         child: Container(
                    //           width: state.banner.size.width.toDouble(),
                    //           height: state.banner.size.height.toDouble(),
                    //           child: AdWidget(ad: state.banner),
                    //         ),
                    //       );
                    //     }  else {
                    //       return SizedBox();
                    //     }
                    //   },
                    // ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previousState, state) {
                    return state is AgreeState;
                  },
                  builder: (context, state) {
                    return ExpandableNotifier(
                        child: Expandable(
                            collapsed: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  checkColor: Colors.red,
                                  activeColor: Colors.transparent,
                                  value: state is AgreeState
                                      ? state.selectedValue
                                      : false,
                                  onChanged: (value) {
                                    // 체크박스 상태 변경 처리
                                    context
                                        .read<HomeBloc>()
                                        .add(AgreeCheckClicked(value!));
                                  },
                                ),
                                Text('정보수집에 동의합니다.'),
                                // Spacer(),
                                ExpandableButton(
                                    child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 35))
                              ],
                            ),
                            expanded: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.red,
                                      activeColor: Colors.transparent,
                                      value: state is AgreeState
                                          ? state.selectedValue
                                          : false,
                                      onChanged: (value) {
                                        // 체크박스 상태 변경 처리
                                        context
                                            .read<HomeBloc>()
                                            .add(AgreeCheckClicked(value!));
                                      },
                                    ),
                                    Text('정보수집에 동의합니다.'),
                                    Spacer(),
                                    ExpandableButton(
                                        child: Icon(
                                            Icons.keyboard_arrow_up_rounded,
                                            size: 35))
                                  ],
                                ),
                                SizedBox(
                                  height: 160,
                                  child: SingleChildScrollView(
                                    child: Text('''
                        1. 본인은 회사가 “사진”을 다음과 같이 이용하는 것에 동의 합니다.
                          1) 이용 저작물 : 관상 서비스에 업로드한 "사진"
                          2) 이용 방법
                            - 광고 및 홍보용 게시물 등에 사용
                            - “사진”을 그대로 또는 2차 저작물 작성, 복제, 공개 전송, 배포 등의 방법으로 이용
                        2. 본인은 본 동의에 따라 회사가 이용하고자 하는 “사진”에 대한 초상권, 저작권(2차 저작물 작성권 등 포함) 등의 본래적, 파생적, 부수적 권리 일체에 대한 권리자로서 다음과 같은 사항을 회사에 보증하며, 이에 대한 이용을 허락합니다.
                          1) “사진”에 포함된 초상은 본인의 초상(성명, 예명 포함)이며, 본 동의에 따라 이용을 허락 합니다.
                          2) “사진”은 본인에 의해 창작된 저작물로서 제3자의 지적재산권, 초상권 및 기타 권리를 도용, 표절 및 허락 없이 이용하지 않았으며, 관련 법률도 위반하지 않았습니다.
                          3) “사진”과 관련하여 회사가 이용함에 있어 제3자와 분쟁 등이 발생하는 경우 본인의 책임과 비용으로 해결하고 회사를 면책하겠습니다.
                          4) 회사는“사진”에 어떠한 책임도 없음에 동의합니다.
                        3. 사진 이용에 대한 대가
                          본인은 본 동의에 따라 “사진”의 이용을 대가 없이 회사에게 허락함을 동의합니다.''',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                              ],
                            )));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Route _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       return FadeTransition(
  //         opacity: animation,
  //         child: child,
  //       );
  //     },
  //   );
  // }

  Route _createRouteToLoadingScreen(
      String imgPath, Uint8List? imgBytes, String gender, bool agreeYn) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          RepositoryProvider(
        create: (context) => KwansangApi(),
        child: BlocProvider(
          create: (context) => WaitingBloc(context.read<KwansangApi>())
            ..add(WaitingScreenInit(imgPath, imgBytes, gender, agreeYn)),
          child: WaitingScreen(imgPath, gender, agreeYn),
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
