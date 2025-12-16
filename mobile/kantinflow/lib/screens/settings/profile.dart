import 'package:flutter/material.dart';
import 'package:kantin_management/models/user.dart';
import 'package:kantin_management/screens/settings/edit_profile_image.dart';
import 'package:kantin_management/services/api_services.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget{

  User user;

  Profile({
    super.key, 
    required this.user,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);
  final TextEditingController _controller = TextEditingController();

  String _selectedGender = "Male";


  String hideEmail(String email){
    String firstThreeLetters = email.substring(0,3);
    String lastThreeLetters = email.split('@')[1];
    return "$firstThreeLetters****$lastThreeLetters";
  }

  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(
          color: mainColor,
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

  void getUser() async {
    User newUser = await ApiServices().getUser();
    setState(() {
      widget.user = newUser;
    });
  }

  void editUser(String field, String fieldData) async {
    showLoading(context);

    Future<dynamic> Function() updateFunction;

    switch (field) {
      case "Firstname":
        updateFunction = () => ApiServices().updateUser(firstName: fieldData);
        break;
      case "Lastname":
        updateFunction = () => ApiServices().updateUser(lastName: fieldData);
        break;
      case "Gender":
        updateFunction = () => ApiServices().updateUser(gender: fieldData);
        break;
      case "Address":
        updateFunction = () => ApiServices().updateUser(address: fieldData);
        break;
      default:
        hideLoading(context);
        showToast(context, "Error: Unknown field '$field'");
        return;
    }

    try {
      final data = await updateFunction();

      if (data["message"].toString() == "Profile updated successfully") {
        getUser();
        hideLoading(context);
        Navigator.pop(context); 
      } else {
        showToast(context, "Unable to update $field: ${data['message']}");
      }
    } catch (e) {
      hideLoading(context);
      showToast(context, "An error occurred while updating $field.");
    }
  }

  void _showPicker(BuildContext context, String title, TextEditingController controller) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: SafeArea(
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Edit $title",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.0
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextSelectionTheme(
                      data: TextSelectionThemeData(
                        selectionColor: Colors.grey.shade400,
                        cursorColor: Colors.grey.shade600,
                        selectionHandleColor: Colors.black,
                      ),
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: Colors.grey.shade300
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2.0
                            )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8.0)
                          )
                        ),
                        child: Text("Cancel")
                      ),
                    ),
                    SizedBox(width: 8.0,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          editUser(title, controller.text.trim());
                        }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade300,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8.0)
                          )
                        ),
                        child: Text("Edit")
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showGenderPicker(BuildContext context) {
    _selectedGender = widget.user.gender ?? "Male"; // default

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Edit Gender",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                ),

                DropdownButtonFormField<String>(
                  initialValue: _selectedGender,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300
                      )
                    ),
                  ),
                  items: const ["Male", "Female", "Others"]
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _selectedGender = value;
                    }
                  },
                ),

                Container(
                  margin: EdgeInsets.all(8.0),
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8.0)
                          )
                        ),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          editUser("Gender", _selectedGender);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade300,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8.0)
                          )
                        ),
                        child: const Text("Edit"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "My Profile",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: Color.fromARGB(255, 245, 245, 245),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.user.profileImageUrl != null
                            ?
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    widget.user.profileImageUrl!,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              ),
                              child: Image.network(
                                widget.user.profileImageUrl!,
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            )
                            :
                            Image.asset(
                              "assets/images/profile.png",
                              width: 130,
                              height: 130,
                            ),
                            Text(
                              widget.user.firstName,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
            
                      Container(
                        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async{
                                final result = await Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => EditProfileImage())
                                );

                                if (result == true) {
                                  getUser();
                                }
                              }, 
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(8.0)
                                ),
                              ),
                              child: Text(
                                "Edit"
                              )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.0,),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: (){
                          setState(() {
                            _controller.text = widget.user.firstName;
                          });
                          _showPicker(context, "Firstname", _controller);
                        }, 
                        style: TextButton.styleFrom(
                          overlayColor: Colors.white,
                          foregroundColor: Colors.blue.shade300
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Firstname",
                              style: TextStyle(
                                color: Color.fromARGB(255, 70, 70, 70),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.user.firstName,
                                ),
                                SizedBox(width: 4.0,),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12.0,
                                )
                              ],
                            )
                          ],
                        )
                      ),
                      SizedBox(height: 10.0,),
                      TextButton(
                        onPressed: (){
                          setState(() {
                            _controller.text = widget.user.lastName;
                          });
                          _showPicker(context, "Lastname", _controller);
                        }, 
                        style: TextButton.styleFrom(
                          overlayColor: Colors.white,
                          foregroundColor: Colors.blue.shade300
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Lastname",
                              style: TextStyle(
                                color: Color.fromARGB(255, 70, 70, 70),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.user.lastName,
                                ),
                                SizedBox(width: 4.0,),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12.0,
                                )
                              ],
                            )
                          ],
                        )
                      ),
                      SizedBox(height: 10.0,),
                      TextButton(
                        onPressed: (){}, 
                        style: TextButton.styleFrom(
                          overlayColor: Colors.white,
                          foregroundColor: Colors.blue.shade300
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                color: Color.fromARGB(255, 70, 70, 70),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  hideEmail(widget.user.email),
                                ),
                              ],
                            )
                          ],
                        )
                      ),
                      SizedBox(height: 10.0,),
                      TextButton(
                        onPressed: (){
                          widget.user.gender != null 
                          ?
                            (){}
                          :
                            _showGenderPicker(context);
                        }, 
                        style: TextButton.styleFrom(
                          overlayColor: Colors.white,
                          foregroundColor: Colors.blue.shade300
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Gender",
                              style: TextStyle(
                                color: Color.fromARGB(255, 70, 70, 70),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.user.gender != null ? widget.user.gender! : "",
                                  style: TextStyle(
                                    
                                  ),
                                ),
                                widget.user.gender != null 
                                ?
                                  Container()
                                :
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12.0,
                                )
                              ],
                            )
                          ],
                        )
                      ),
                      SizedBox(height: 10.0,),
                      TextButton(
                        onPressed: (){
                            setState(() {
                            _controller.text = widget.user.address != null ? widget.user.address! : "";
                          });
                          _showPicker(context, "Address", _controller);
                        }, 
                        style: TextButton.styleFrom(
                          overlayColor: Colors.white,
                          foregroundColor: Colors.blue.shade300
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Address",
                              style: TextStyle(
                                color: Color.fromARGB(255, 70, 70, 70),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.user.address != null ? widget.user.address! : "",
                                  style: TextStyle(
                                    
                                  ),
                                ),
                                SizedBox(width: 4.0,),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12.0,
                                )
                              ],
                            )
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
