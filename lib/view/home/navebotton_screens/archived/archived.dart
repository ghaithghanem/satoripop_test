import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Archived extends StatefulWidget {

  const Archived({super.key});

  @override
  State<Archived> createState() => _ArchivedState();
}

class _ArchivedState extends State<Archived> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty 1.png', // Your image asset
              width: 150, // Adjust the width as needed
              height: 150, // Adjust the height as needed
            ),
            SizedBox(height: 16),
            Text(
              "No chat history found",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Caladea',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "There are no existing conversations or chat history available.",
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Caladea',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
