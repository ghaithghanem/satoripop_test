import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart'; // Import the package

import '../utils/user_session.dart';
import 'auth/login_view.dart';
import 'home/home.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SplashWidget(), // Custom widget for animation
      nextScreen: _navigate(), // Pass the function reference
      splashTransition: SplashTransition.fadeTransition, // Optional transition
      animationDuration: Duration(seconds: 2), // Adjust animation duration
      splashIconSize: 350, // Target width for the logo after animation
    );
  }

  Widget _navigate() {
    // Check if user is logged in
    Future<bool> isLoggedIn = UserSession.isLoggedIn();

    return FutureBuilder<bool>(
      future: isLoggedIn,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data! ? Home() : LoginView();
        } else if (snapshot.hasError) {
          // Handle error
          return Container();
        }
        // Show loading indicator while checking user session
        return CircularProgressIndicator();
      },
    );
  }
}

// Custom widget for splash animation
class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(seconds: 1), // Adjust duration as needed
        width: 120, // Initial width
        height: 120, // Initial height
        child: Image.asset(
          'assets/images/logo_splashscreen.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
