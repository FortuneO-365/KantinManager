import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget{
  final IconData icon;
  final String title;
  final String content;
  final Color mainColor;
  final String buttonMessage;
  final VoidCallback action;

  const CustomAlertDialog(this.icon, this.title, this.content, this.mainColor, this.buttonMessage, this.action,{super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: 
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
            child: Icon(
              icon,
              size: 30.0,
            ),
          ),
          content: SizedBox(
            height: 90.0,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  content,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // your action
                action;
              },
              style: TextButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(buttonMessage),
            ),
          ],
        );
  }
}