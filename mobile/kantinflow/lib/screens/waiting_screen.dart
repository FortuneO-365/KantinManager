import 'package:flutter/material.dart';
import 'package:kantin_management/main.dart';
import 'package:kantin_management/models/user.dart';
import 'package:kantin_management/screens/auth/login.dart';
import 'package:kantin_management/services/api_services.dart';
import 'package:kantin_management/services/auth_initializer.dart';
import 'package:kantin_management/services/backend_warmup.dart';
import 'package:lottie/lottie.dart';

class WaitingScreen extends StatefulWidget{
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  Future<void> initialize() async {

    bool backendReady = false;

    for (int i = 0; i < 10; i++) {
      backendReady = await BackendWarmup.wakeUp();
      if (backendReady) {
        break;
      }
      await Future.delayed(const Duration(seconds: 4));
    }

    if (!backendReady) {
      // Optional: show error screen
      return;
    }



    bool loggedIn = await AuthInitializer.tryAutoLogin();

    if (!mounted) return;

    if (loggedIn) {
      try {
        User user = await ApiServices().getUser();
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
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'splash_logo',
              child: SizedBox(
                width: 100,
                child: Lottie.asset(
                  'assets/animations/soft_pulse_animation.json',
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Server is waking up",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Please wait...",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}