import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kwansang/data/models/result_response_dto.dart';
import 'package:share_plus/share_plus.dart';
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
                ClipOval(
                  child: Image.network(
                    '${Constants.baseUrl}/${result.predictedJob2Image}',
                    width: 50,
                    height: 50,
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
                ClipOval(
                  child: Image.network(
                    '${Constants.baseUrl}/${result.predictedJob3Image}',
                    width: 50,
                    height: 50,
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
                  onPressed: () {
                    final queryParam = "predictedJob1=${result.predictedJob1}&predictedJob1Image=${result.predictedJob1Image}";
                    final encodedParam = Uri.encodeComponent(queryParam);
                    var uri = kIsWeb?"${Uri.base.origin}/#/result?${encodedParam}":"/#/result?${encodedParam}";

                    Clipboard.setData(ClipboardData(text: uri));

                    Share.share(uri, subject: 'ai가 본 친구의 관상을 확인해보세요!');
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
