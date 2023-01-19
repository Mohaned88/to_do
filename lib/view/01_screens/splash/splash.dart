import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/control/local/task_cubit.dart';
import 'package:to_do/view/01_screens/body/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<TaskCubit>(context).createDb();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context){
            BlocProvider.of<TaskCubit>(context).getDataBase();
            return HomeScreen();
          },
        ),
      ),
    );
    return const Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Text(
          "To Do",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
