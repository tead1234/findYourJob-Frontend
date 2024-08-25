import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwansang/bloc/home/home_bloc.dart';
import 'package:kwansang/repository/kwansang_api.dart';
import 'package:kwansang/screens/result_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/': (context) => RepositoryProvider(
          create: (context) => KwansangApi(),
          child: BlocProvider(
            create: (context) => HomeBloc(context.read<KwansangApi>()),
            child: HomeScreen(),
          ),
        ),
        '/result': (context) => ResultScreen(),
        //'/waiting': (context) => Waiting(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}