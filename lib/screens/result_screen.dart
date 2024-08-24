
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kwansang/data/models/result_response_dto.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultScreen extends StatelessWidget {
  final String imageUrl = 'https://www.google.com/imgres?q=%EA%B4%80%EC%83%81&imgurl=https%3A%2F%2Fi.namu.wiki%2Fi%2FJNmmvzr3JP1TMVGGFvckRVLS5t5Vef978NpmjEf0QSNh5db4sMyqXNS8wqJv8TrjLqrJAx-xNCQcCUmu30QI_Q.webp&imgrefurl=https%3A%2F%2Fnamu.wiki%2Fw%2F%25EA%25B4%2580%25EC%2583%2581(%25EC%2598%2581%25ED%2599%2594)&docid=F_KxY1RZALHzeM&tbnid=MT6kY-72CZhzMM&vet=12ahUKEwiBpNCrq5eHAxXmoa8BHXGHBiAQM3oECGMQAA..i&w=678&h=971&hcb=2&ved=2ahUKEwiBpNCrq5eHAxXmoa8BHXGHBiAQM3oECGMQAA'; // 대체 이미지 URL
  final ResultResponseDto result;
  final String imgPath;

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  ResultScreen(this.result,this.imgPath);

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
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                result.predictedJob1Image!,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
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
                    result.predictedJob2Image!,
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
                    result.predictedJob3Image!,
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
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => _launchURL('https://twitter.com'),
                  tooltip: 'Twitter',
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => _launchURL('https://facebook.com'),
                  tooltip: 'Facebook',
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => _launchURL('https://kakao.com'),
                  tooltip: 'KakaoTalk',
                ),
                IconButton(
                  icon: Icon(Icons.link),
                  onPressed: () => _launchURL('https://example.com'),
                  tooltip: 'URL',
                ),
              ],
            ),
            SizedBox(height: 10,),
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
                    recognizer: TapGestureRecognizer()..onTap = () {
                      // onTap Event
                      _launchURL('https://www.notion.so/jpko123/ai-8c608989719a4afd8b77cdbbfaa3ccb1');
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