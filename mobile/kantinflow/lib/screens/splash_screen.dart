import 'package:flutter/material.dart';
import 'package:kantin_management/main.dart';
import 'package:kantin_management/models/user.dart';
import 'package:kantin_management/screens/auth/login.dart';
import 'package:kantin_management/services/api_services.dart';
import 'package:kantin_management/services/auth_initializer.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> initialize() async {
    bool loggedIn = await AuthInitializer.tryAutoLogin();

    if (!mounted) return;

    if (loggedIn) {
      try {
        User user = await ApiServices().getUser();
        print(user.toJson());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(user: user)),
        );
        
      } catch (e) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Login()),
        );  
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Login()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), initialize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/animations/soft_pulse_animation.json',
          width: 200,
        ),
      ),
    );
  }
}
