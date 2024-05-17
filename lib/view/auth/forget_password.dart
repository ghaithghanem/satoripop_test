import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  static const double horizontalTextFieldPadding = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Image.asset('assets/images/logo_login.png', width: 220, height:120),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, bottom: 0.0, right: 110.0),
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Caladea',
                        letterSpacing: -0.34,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, bottom: 0.0, right: 50.0),
                    child: Text(
                      'No password? No problem! We’ll email you with\ninstructions for setting your password.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Caladea',
                        letterSpacing: -0.34,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 60),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Text(
                          'Your mail',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Caladea',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalTextFieldPadding),
                        child: Container(
                          width: 320,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'e-mail',
                                hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                                prefixIcon: Icon(Icons.email_outlined),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 49.0),
                  Container(
                    width: 320.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 0.0),
                            child: Text(
                              'Send',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Caladea',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 110.0),
                ],
              ),
            ),
            Positioned(
              top: 26.0,
              left: 26.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Navigate back to the previous screen
                },
                child: Image.asset(
                  'assets/images/backbutton.png', // Your image asset for the button
                  width: 40, // Adjust the width as needed
                  height: 40, // Adjust the height as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}