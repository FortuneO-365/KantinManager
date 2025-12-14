import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kantin_management/services/api_services.dart';
import 'package:kantin_management/widgets/text_form_field.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  TextEditingController cOldPassword = TextEditingController();
  TextEditingController cNewPassword = TextEditingController();
  TextEditingController cConfirmNewPassword = TextEditingController();

  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(
          color: Colors.blue.shade300,
          backgroundColor: const Color.fromARGB(50, 255, 255, 255),
        ),
      ),
    );
  }

  void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  void showToast(BuildContext context,String message){
    // Implement toast message display
      OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0, // Position from the bottom
        left: MediaQuery.of(context).size.width * 0.1, // Center horizontally
        right: MediaQuery.of(context).size.width * 0.1, // Center horizontally
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    Overlay.of(context).insert(overlayEntry);

    // Remove the overlay entry after a delay
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  bool validateInput(BuildContext context){
    final String oldPassword = cOldPassword.text.trim();
    final String newPassword = cNewPassword.text.trim();
    final String confirmPassword = cConfirmNewPassword.text.trim();

    if( oldPassword == ""){
      showToast(context, "Old Password field can't be empty");
      return false;
    }
    if( newPassword == ""){
      showToast(context, "New Password field can't be empty");
      return false;
    }
    if( confirmPassword == ""){
      showToast(context, "Confirm Password field can't be empty");
      return false;
    }
    if( confirmPassword != newPassword){
      showToast(context, "Passwords do not match");
      return false;
    }
    if( oldPassword == newPassword){
      showToast(context, "Old Password can't be the same as New password");
      return false;
    }

    return true;
  }

  void changePassord(BuildContext context) async{
    final bool isValid = validateInput(context);
    if(isValid){
      showLoading(context);
      final data = await ApiServices().changePassword(
        oldPassword: cOldPassword.text.trim(), 
        newPassword:  cNewPassword.text.trim()
      );
      hideLoading(context);

      print(data);

      if(data.toString() == "Password Changed Successfully"){
        showToast(context, "Password changed successfully");
        Navigator.pop(context);
      }else if(data.toString() == "Old Password is incorrect"){
        showToast(context, "Old Password is incorrect");
      }else{
        showToast(context, "Unable to change password. Try again later");
      }
    }
  }

  @override
  Widget build(BuildContext context){
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
          "Change Password",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Old Password',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              CustomTextFormField(
                prefixIcon: Icons.lock_outline,
                labelText: 'Old Password',
                controller: cOldPassword,
                isPassword: true,
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              CustomTextFormField(
                prefixIcon: Icons.lock_outline,
                labelText: 'New Password',
                controller: cNewPassword,
                isPassword: true,
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    'Confirm New Password',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              CustomTextFormField(
                prefixIcon: Icons.lock_outline,
                labelText: 'Confirm new Password',
                controller: cConfirmNewPassword,
                isPassword: true,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  changePassord(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue.shade300,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(4.0)
                  )
                ),
                child: Text('SUBMIT'),
              ),
            ],
          ),
        ),
    );
  }
}