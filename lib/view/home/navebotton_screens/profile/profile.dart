import 'package:flutter/material.dart';
import '../../../../utils/token_manager.dart';
import '../../../auth/login_view.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilScreen> {
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _showLogoutConfirmationDialog,
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to your profile!'),
      ),
    );
  }
}
