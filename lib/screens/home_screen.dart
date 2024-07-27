
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwansang/screens/result_screen.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

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
            SizedBox(
              height: 180,
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
                            child: Center(child: CircularProgressIndicator()),
                            height: 100.0,
                            width: 100.0,
                          );
                        } else if (state is ImageLoadSuccess) {
                          return Image.network(
                            state.imagePath,
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
                        ElevatedButton(
                          onPressed: () {
                            context.read<HomeBloc>().add(ImagePicked());
                          },
                          child: Text('이미지 열기'),
                        ),
                        SizedBox(height: 20),
                        Text('성별 선택:'),
                        BlocBuilder<HomeBloc, HomeState>(
                          buildWhen: (previousState, state) {
                            return state is RadioState;
                          },
                          builder: (context, state) {
                            return Row(
                              children: [
                                Radio<String>(
                                  value: '남성',
                                  groupValue: state is RadioState
                                      ? (state).selectedValue
                                      : '',
                                  onChanged: (value) {
                                    // 성별 선택 이벤트 처리
                                    context
                                        .read<HomeBloc>()
                                        .add(RadioClicked(value!));
                                  },
                                ),
                                Text('남성'),
                                Radio<String>(
                                  value: '여성',
                                  groupValue: state is RadioState
                                      ? (state).selectedValue
                                      : '',
                                  onChanged: (value) {
                                    // 성별 선택 이벤트 처리
                                    context
                                        .read<HomeBloc>()
                                        .add(RadioClicked(value!));
                                  },
                                ),
                                Text('여성'),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(280, 50),
                  ),
                  onPressed: () {
                    Navigator.push(context, _createRoute());
                  },
                  child: Text('관상 직업 확인하기'),
                )
              ],
            ),
            Spacer(),
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previousState, state) {
                return state is AgreeState;
              },
              builder: (context, state) {
                return ExpandableNotifier(
                    child: Expandable(
                        collapsed: Row(
                          children: [
                            Checkbox(
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
                                child: Icon(Icons.keyboard_arrow_down_rounded,
                                    size: 35))
                          ],
                        ),
                        expanded: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
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
                                    child: Icon(Icons.keyboard_arrow_up_rounded,
                                        size: 35))
                              ],
                            ),
                            SizedBox(height: 160,
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
                                      fontSize: 11.0, color: Colors.black,
                                    )),
                              ),
                            ),
                          ],
                        )));
              },
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
