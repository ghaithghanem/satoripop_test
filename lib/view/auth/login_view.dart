import 'package:flutter/material.dart';

import '../../api/view_model/auth_view_model.dart';
import '../../utils/api_view_handler.dart';
import '../../utils/token_manager.dart';
import '../../utils/user_session.dart';
import '../home/home.dart';
import '../home/navebotton_screens/profile/interface_userprofile.dart';
import '../splash_screen.dart';
import 'forget_password.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // UI
  AuthViewModel authViewModel = AuthViewModel();

  // UI
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  bool isChecked = false;
  bool _isPasswordVisible = false;

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadRememberMe();
  }

  void loadRememberMe() async {
    await TokenManager.loadTokenAndRememberMe();
    if (TokenManager.rememberMe != null) {
      setState(() {
        isChecked = TokenManager.rememberMe!;
      });
    }
  }

  void login() {
    ApiViewHandler.handleApiCallWithAlert(
      context: context,
      apiCall: () => authViewModel.login(
        email: _emailController.text.toLowerCase(),
        password: _passwordController.text,
      ),
      successFunction: () async {
        final token = authViewModel.apiResponse.data as String;
        if (isChecked) {
          await TokenManager.saveTokenAndRememberMe(token, true);
        } else {
          await TokenManager.saveTokenAndRememberMe(token, false);
        }
        print("Token stored: $token");
        await UserProfileAPI.getUserProfile();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    const double horizontalTextFieldPadding = 25.0; // Adjust the horizontal padding value as needed

    return Scaffold(
        backgroundColor: Colors.black,
        body: Form(
        key: _keyForm,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Image.asset('assets/images/logo_login.png', width: 200, height: 120),
                  ),
                ),

                SizedBox(height: 25),


                Padding(
                  padding: const EdgeInsets.only(left: 0.0, bottom: 0.0,right: 50.0,),
                    child: Text(
                      'Welcome back!\nGlad to see you, Again!',
                      textAlign: TextAlign.start, // Added to ensure text is centered horizontally
                      style: TextStyle(
                        fontSize: 30,
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Caladea',
                        letterSpacing: -0.34,
                        color: Colors.white,
                      ),
                    ),

                ),


                SizedBox(height: 60),

                // Username TextField with label
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0), // Add padding to the left
                      child: Text(
                        'Username', // Label text
                        style: TextStyle(
                          color: Colors.white, // Set label color to white
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
                          child: TextFormField(
                            controller: _emailController,
                            focusNode: _emailFocus,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              prefixIcon: Icon(Icons.perm_identity),
                              hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                              border: InputBorder.none, // Remove the default border
                            ),
                            keyboardType: TextInputType.emailAddress, // Set keyboard type to email address
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is required'; // Validation error message for empty email
                              } else if (!RegExp(r"^[a-zA-Z0-9a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                return 'Invalid email format'; // Validation error message for invalid email format
                              }
                              return null; // Return null for no validation error
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),



                SizedBox(height: 16), // Add some spacing
                // Password TextField with added padding

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0), // Add padding to the left
                      child: Text(
                        'Password', // Label text
                        style: TextStyle(
                          color: Colors.white, // Set label color to white
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
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: _isPasswordVisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
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
                SizedBox(height: 11),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Align children horizontally at the center
                    children: [

                      SizedBox(
                        width: 17.0, // Adjust width to match the size of the Checkbox
                        height: 17.0, // Adjust height to match the size of the Checkbox
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 0.5),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                            //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            //activeColor: Colors.white,
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, bottom: 0.0),
                        child: Center(
                          child: Text(
                            'Remember me', // Label text
                            style: TextStyle(
                              color: Colors.white, // Set label color to white
                              fontFamily: 'Caladea', // Set label font to Caladea
                              fontSize: 12, // Set label font size
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 75), // Add spacer to push "Forgot Your Password?" to the right
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, bottom: 0.0),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgetPassword()),
                              );
                            },
                            child: Text(
                              'Forgot Your Password?',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Caladea',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),


                // RichText with clickable "Forgot your password?"

                SizedBox(height: 56.0),
                Container(
                  width: 320.0, // Set your desired width
                  height: 50.0, // Set your desired height
                  child: ElevatedButton(
                    onPressed: () {
                      if (_keyForm.currentState!.validate()) {
                        _keyForm.currentState!.save();
                        login();

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(35.0),
                      ),

                      primary:  Colors.white,
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 0.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Caladea',
                              color: Colors.black, // Set your desired text color
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 120.0),

              ],
            ),
          ),
        ),

        ),
    );
  }






}
