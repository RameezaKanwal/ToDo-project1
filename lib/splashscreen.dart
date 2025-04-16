import 'package:flutter/material.dart';
import 'package:flutter_project/homescreen.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    //TODO : initState
    super.initState();
    moveToNextScreen();
  }
  Future<void> moveToNextScreen() async{
    await Future.delayed(Duration(seconds:4));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Stack(
        children: [
          Container(
            child: Image.asset("assets/todo.webp"),
            height: double.infinity,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
