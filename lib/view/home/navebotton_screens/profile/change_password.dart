import 'package:flutter/material.dart';

import '../../home.dart';

class Change_Password extends StatefulWidget {
  const Change_Password({super.key});

  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

class _Change_PasswordState extends State<Change_Password> {
  bool _isPasswordVisible = false;
  bool _isnPasswordVisible = false;
  bool _iscPasswordVisible = false;
  FocusNode _passwordFocus = FocusNode();
  FocusNode _newpasswordFocus = FocusNode();
  FocusNode _confirmpasswordFocus = FocusNode();
  TextEditingController _newpasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
   double horizontalTextFieldPadding = 25.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Black background container
          Container(
            height: 122,
            color: Colors.black,
            child: Column(
              children: [
                SizedBox(height: 60),
                Row(
                  children: [
                    SizedBox(width: 16),
                    // White arrow
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                              (Route<dynamic> route) => false,
                        ); // Navigate back to the previous screen
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/retunrpass.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ),
               // Add some space between the arrow and the circle image
                    // Circle image

                    SizedBox(width: 60), // Add some space between the circle image and the text
                    // Text
                    Center(
                      child: Text(
                        'Current password',
                        textAlign: TextAlign.center, // Align text center
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Caladea",
                        ),
                      ),
                    )


                    // Add some space after the icon
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
          SizedBox(height: 65),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0), // Add padding to the left
                child: Text(
                  'Current Password', // Label text
                  style: TextStyle(
                    color: Colors.black, // Set label color to white
                    fontFamily: 'Caladea', // Set label font to Caladea
                    fontSize: 18, // Set label font size
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalTextFieldPadding),
                child: Container(
                  width: 320, // Adjust the width as needed
                  height: 45, // Adjust the height as needed
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(20.0), // Adjust the border radius as needed
                    color: Colors.white, // Set the background color to grey
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0), // Adjust the inner padding as needed
                    child: TextField(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      decoration: InputDecoration(
                        hintText: 'Current Password',
                        hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                       // prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: _iscPasswordVisible
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined),
                          onPressed: () => setState(
                                  () => _iscPasswordVisible = !_iscPasswordVisible),
                        ),
                        border: InputBorder.none, // Remove the default border
                        // Customize other properties as needed
                      ),
                      obscureText: _iscPasswordVisible,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 17),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0), // Add padding to the left
                child: Text(
                  'New Password', // Label text
                  style: TextStyle(
                    color: Colors.black, // Set label color to white
                    fontFamily: 'Caladea', // Set label font to Caladea
                    fontSize: 18, // Set label font size
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalTextFieldPadding),
                child: Container(
                  width: 320, // Adjust the width as needed
                  height: 45, // Adjust the height as needed
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(20.0), // Adjust the border radius as needed
                    color: Colors.white, // Set the background color to grey
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0), // Adjust the inner padding as needed
                    child: TextField(
                      controller: _newpasswordController,
                      focusNode: _newpasswordFocus,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                        //prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: _isnPasswordVisible
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined),
                          onPressed: () => setState(
                                  () => _isnPasswordVisible = !_isnPasswordVisible),
                        ),
                        border: InputBorder.none, // Remove the default border
                        // Customize other properties as needed
                      ),
                      obscureText: _isnPasswordVisible,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0), // Add padding to the left
                child: Text(
                  'Confirm Password', // Label text
                  style: TextStyle(
                    color: Colors.black, // Set label color to white
                    fontFamily: 'Caladea', // Set label font to Caladea
                    fontSize: 18, // Set label font size
                  ),
                ),
              ),
              SizedBox(height: 18),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalTextFieldPadding),
                child: Container(
                  width: 320, // Adjust the width as needed
                  height: 45, // Adjust the height as needed
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(20.0), // Adjust the border radius as needed
                    color: Colors.white, // Set the background color to grey
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0), // Adjust the inner padding as needed
                    child: TextField(
                      controller: _confirmpasswordController,
                      focusNode: _confirmpasswordFocus,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                        //prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: _isPasswordVisible
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined),
                          onPressed: () => setState(
                                  () => _isPasswordVisible = !_isPasswordVisible),
                        ),
                        border: InputBorder.none, // Remove the default border
                        // Customize other properties as needed
                      ),
                      obscureText: _isPasswordVisible,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 48),
          Container(
            width: 320.0,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Text(
                      'Change password',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Caladea',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
