import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kwansang/data/models/result_response_dto.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class ResultScreen extends StatelessWidget {

  final ResultResponseDto result;
  final String imgPath;

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  ResultScreen(this.result, this.imgPath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('관상 직업 추천'),
        leading: BackButton(onPressed: (){Navigator.popUntil(context, ModalRoute.withName("/"));},),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '당신의 관상 직업은..',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imgPath!="noImg") ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: kIsWeb
                      ? Image.network(
                          imgPath,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : Image.file(File(imgPath),
                          width: 150, height: 150, fit: BoxFit.cover),
                ),
                if (imgPath!="noImg") SizedBox(
                  width: 30,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    '${Constants.baseUrl}/${result.predictedJob1Image}',
                    // imgPath,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '${result.predictedJob1} 입니다..!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "2순위 : ${result.predictedJob2}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    '${Constants.baseUrl}/${result.predictedJob2Image}',
                    // imgPath,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "3순위 : ${result.predictedJob3}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    '${Constants.baseUrl}/${result.predictedJob3Image}',
                    // imgPath,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () async {
                    // 직업명 urf-8 인코딩 및 '_' 로 연결한 스트링으로 저장
                    final job1Encode = utf8.encode(result.predictedJob1??'').join('_');
                    final job2Encode = utf8.encode(result.predictedJob2??'').join('_');
                    final job3Encode = utf8.encode(result.predictedJob3??'').join('_');
                    final queryParam = "predictedJob1=${job1Encode}&predictedJob1Image=${result.predictedJob1Image}&predictedJob2=${job2Encode}&predictedJob2Image=${result.predictedJob2Image}&predictedJob3=${job3Encode}&predictedJob3Image=${result.predictedJob3Image}";
                    final encodedParam = Uri.encodeComponent(queryParam);
                    var uri = kIsWeb?"${Uri.base.origin}/#/result?${queryParam}":"/#/result?${queryParam}";
                    // var uri = kIsWeb?"http://iwillguessyourjob.uno/#/result?${encodedParam}":"/#/result?${encodedParam}";
                    const subject = 'ai가 본 친구의 관상을 확인해보세요!\n\n';

                    //클립보드에 복사
                    Clipboard.setData(ClipboardData(text: uri));

                    //짧은 url 생성
                    // var shortUrl = await bitlyApi.getShortUrl(uri);

                    //uri encode
                    uri = Uri.encodeComponent(uri);

                    launchUrl(Uri(scheme: "sms",path:'&body="$subject$uri"'));
                  },
                  child: Row(
                    children: [
                      Text("결과 공유하기"),
                      SizedBox(width: 15),
                      Icon(Icons.link)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Production : Team CHUIIICK .\n',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'About us',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 10,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // onTap Event
                        _launchURL(
                            'https://www.notion.so/jpko123/ai-8c608989719a4afd8b77cdbbfaa3ccb1');
                      },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
