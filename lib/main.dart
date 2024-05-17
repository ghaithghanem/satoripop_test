import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_satoripop/view/splash_screen.dart';
import 'package:test_satoripop/view/widgets/loading_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: true, // Optionally use default loading indicator
      overlayColor: Colors.transparent, // Customize overlay color if needed
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(), // Set the splash screen as the home
      ),
    );
  }
}

