import 'package:flutter/material.dart';
import 'package:kantin_management/screens/notification/notification_setttings.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 18,
        ),
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        shape: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.white70
          )
        ),
        title: Text(
          "Notifications",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("You have not enabled notifications yet."),
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationSetttings()));
              }, 
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue[300],
                overlayColor: Colors.transparent,
                padding: EdgeInsets.all(0),
              ),
              child: Text("Enable Notifications")
            )
          ],
        ),
      ),
    );
  }
}