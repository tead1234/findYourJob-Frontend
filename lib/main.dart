import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kwansang/bloc/home/home_bloc.dart';
import 'package:kwansang/repository/kwansang_api.dart';
import 'package:kwansang/screens/result_screen.dart';
import 'data/models/result_response_dto.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: {
        '/': (context) => RepositoryProvider(
              create: (context) => KwansangApi(),
              child: BlocProvider(
                create: (context) => HomeBloc(context.read<KwansangApi>()),
                child: HomeScreen(),
              ),
            ),
      },
      onGenerateRoute: (settings) {
        final settingsUri = Uri.parse(settings.name!);
        log('sdfikuhsaf');
        log(settingsUri.queryParameters
            .map((k, v) => MapEntry(k, Uri.decodeComponent(v)))
            .toString());
        if (settingsUri.path == "/result") {
          final resultResponseDto =
              ResultResponseDto.fromMap(settingsUri.queryParameters.map((k, v) {
            if (k == 'predictedJob1' || k == 'predictedJob2' || k == 'predictedJob3') {
              return MapEntry(k,
                  // utf8.decode(json.decode(Uri.decodeComponent(v).split('_')).cast<int>()));,
                utf8.decode(v.split('_').map((v)=>int.parse(v)).toList()));
            }
            else {
              return MapEntry(k, Uri.decodeComponent(v));
            }
          }));

          log(settingsUri.queryParameters
              .map((k, v) => MapEntry(k, Uri.decodeComponent(v)))
              .toString());
          log(resultResponseDto.predictedJob1Image ?? "");

          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ResultScreen(resultResponseDto, "noImg"),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        }
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
