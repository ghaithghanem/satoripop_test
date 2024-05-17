import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navebotton_screens/archived/archived.dart';
import 'navebotton_screens/inbox/inbox.dart';
import 'navebotton_screens/profile/change_password.dart';
import 'navebotton_screens/profile/interface_userprofile.dart';
import 'navebotton_screens/profile/profile.dart';
import 'navebotton_screens/profile/profilescreen.dart';
import 'navebotton_screens/sent/sent.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  late PageController _pageController;

  String? userPhoto;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index != 4) { // Exclude the Change Password screen
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to the Change Password screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Change_Password()),
      );
    }
  }

  void fetchUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    userPhoto = sharedPreferences.getString(UserProfileAPI.userPhotoUrlKey);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: [
                  InboxTabView(), // Inbox Screen
                  Sent(), // Sent Screen
                  Archived(), // Archived Screen
                  UserProfileScreen(), // Profile Screen
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 30),
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 5, color: Colors.black),
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: () {
              // Handle onPressed event
            },
            shape: CircleBorder(),
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 27,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildNavItem(0, 'Inbox', 'assets/images/inbox.png'),
              _buildNavItem(1, 'Sent', 'assets/images/sent.png'),
              SizedBox(width: 74),
              _buildNavItem(2, 'Archived', 'assets/images/archived.png'),
              _buildNavItem(3, 'Profile', 'assets/images/lisa.png'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String text, String iconAsset) {
    return GestureDetector(
      onTap: () => _navigateToScreen(index),
      child: Container(
        color: _selectedIndex == index ? Color(0xFF363636) : Colors.black,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == index ? Colors.white : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: index == 3 && userPhoto != null
                      ? CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(userPhoto!),
                  )
                      : Image.asset(
                    index == 3 ? 'assets/images/lisa.png' : iconAsset,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              onPressed: () => _navigateToScreen(index),
            ),
            Text(
              text,
              style: TextStyle(
                color: _selectedIndex == index ? Colors.white : Colors.grey,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 80, // Adjust width as needed
              height: 2, // Adjust height as needed
              color: _selectedIndex == index ? Colors.white : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}