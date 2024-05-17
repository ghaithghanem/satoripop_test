import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

import '../../../../utils/token_manager.dart';
import '../../../auth/login_view.dart';

import '../../../message/message_screen.dart';
import 'change_password.dart';
import 'interface_userprofile.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool switchValue = false;
  String? userName;
  String? userEmail;
  String? userPhoto;
  bool _changePasswordClicked = false;
  @override
  void initState() {
    super.initState();
    // Fetch user data from SharedPreferences when the screen is initialized
    fetchUserData();
  }

  // Function to fetch user data from SharedPreferences
  void fetchUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    // Fetch user name, email, and photo url from SharedPreferences
    userName = sharedPreferences.getString(UserProfileAPI.userNameKey);
    userEmail = sharedPreferences.getString(UserProfileAPI.userEmailKey);
    userPhoto = sharedPreferences.getString(UserProfileAPI.userPhotoUrlKey);
    // Update the UI after fetching data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_changePasswordClicked) {
      return Change_Password(); // Navigate to ChangePassword screen if clicked
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Black background container
          Container(
            height: 188,
            color: Colors.black,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: -70, // Adjust this value to position the photo accordingly
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // Change to your desired background color
                    ),
                    child: ClipOval(
                      child: userPhoto != null
                          ? Image.network(
                        userPhoto!, // Use the stored photo url if available
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      )
                          :
                          Image.asset(
                        'assets/images/lisa.png', // Replace with your asset path
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 75), // Spacer between the container and the text
          // Text widgets
          Text(
            " ${userName ?? 'Unknown'}",
            style: TextStyle(
              fontFamily: 'Caladea',
              fontWeight: FontWeight.bold,
              fontSize: 24, // Updated size to 24px
            ),
          ),
          Text(
            "${userEmail ?? 'Unknown'}",
            style: TextStyle(
              color: Color(0xFF000000).withOpacity(0.3), // Updated color to #0000004D
              fontSize: 16,
            ),
          ),
          SizedBox(height: 66), // Spacer between the text and the container
          // Container with text and switcher
          Container(
            width: 390,
            height: 56,
            color: Colors.white, // Adjust color as needed
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(
                    fontFamily: 'Caladea',
                    fontWeight: FontWeight.bold,
                    fontSize: 20, // Updated size to 20px
                  ),
                ),
                SizedBox(width: 156),
                 Padding(
                  padding: const EdgeInsets.all(2.0),
                  child:    Container(
                    width: 2, // Adjust width as needed
                    height: 40, // Adjust height as needed
                    color: Color(0xFFF1F1F1), // Adjust color as needed
                  ),
                ),
                Switch(
                  value: switchValue,
                  onChanged: (newValue) {
                    setState(() {
                      switchValue = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16), // Spacer between the text and the container

          GestureDetector(
            onTap: () {
              setState(() {
                _changePasswordClicked = true;
              });
            },
            child: Container(
              width: 390,
              height: 56,
              color: Colors.white, // Adjust color as needed
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Change Password",
                    style: TextStyle(
                      fontFamily: 'Caladea',
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Updated size to 20px
                    ),
                  ),
                  SizedBox(width: 110),
                  Container(
                    width: 15,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/profile_arrow.png"), // Update asset path if needed
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          SizedBox(height: 16),
          Container(
            width: 390,
            height: 56,
            color: Colors.white, // Adjust color as needed
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Help",
                  style: TextStyle(
                    fontFamily: 'Caladea',
                    fontWeight: FontWeight.bold,
                    fontSize: 20, // Updated size to 20px
                  ),
                ),
                SizedBox(width: 110),

                Container(
                  width: 15,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image:  AssetImage("assets/images/profile_arrow.png"), // Cast AssetImage to ImageProvider
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: _showLogoutConfirmationDialog,
            child: Container(
              width: 390,
              height: 56,
              color: Colors.white, // Adjust color as needed
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Log out",
                    style: TextStyle(
                      fontFamily: 'Caladea',
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Updated size to 20px
                    ),
                  ),
                  SizedBox(width: 120),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:  AssetImage("assets/images/logout.png"), // Cast AssetImage to ImageProvider
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.orange),
              SizedBox(width: 12),
              Text(
                'Confirm Logout',
                style: TextStyle(
                  fontFamily: 'Caladea',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Ensure content only takes up the space it needs
            children: [
              SizedBox(width: 30),
              Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontFamily: 'Caladea'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Caladea',
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                _logout(); // Perform logout
              },
              child: Text(
                'Yes, log out',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Caladea',
                  fontWeight: FontWeight.bold,
                  fontSize: 12, // Adjust the font size as needed
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void _logout() async {
    // Clear the stored token
    await TokenManager.resetToken();

    // Navigate to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
          (Route<dynamic> route) => false,
    );
  }
}