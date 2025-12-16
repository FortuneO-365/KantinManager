import 'package:flutter/material.dart';
import 'package:kantin_management/screens/waiting_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WaitingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
          tag: 'splash_logo',
          child: SizedBox(
            width: 200,
            child: Lottie.asset(
              'assets/animations/soft_pulse_animation.json',
            ),
          ),
        ),
      ),
    );
  }
}
