import 'package:flutter/material.dart';
import 'package:kantin_management/models/user.dart';
import 'package:kantin_management/pages/dashboard.dart';
import 'package:kantin_management/pages/splash_screen.dart';
import 'package:kantin_management/pages/product/products.dart';
import 'package:kantin_management/pages/sales/sales.dart';
import 'package:kantin_management/services/api_client.dart';
import 'package:kantin_management/pages/settings/me.dart';

void main() {
  ApiClient.setupInterceptors();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}


class HomePage extends StatefulWidget {

  final User user;
  const HomePage({
    super.key,
    required this.user
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {

    final List<Widget> _pages = [
      Dashboard(
        name: widget.user.firstName
      ),
      Sales(),
      Products(),
      Settings(
        firstName: widget.user.firstName,
        lastName: widget.user.lastName,
        email: widget.user.email,
      ),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, animation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: slideAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue[300],
        selectedIconTheme: IconThemeData(
          color: Colors.blue[300],
        ),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12
        ),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: "Sales",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Me",
          ),
        ],
      ),
    );
  }
}