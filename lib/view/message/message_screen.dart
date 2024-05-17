import 'package:flutter/material.dart';

import '../home/home.dart';

class MessageScreen extends StatefulWidget {
  final String clientName;
  final String? clientAvatar;

  const MessageScreen({
    Key? key,
    required this.clientName,
    this.clientAvatar,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    SizedBox(width: 16), // Add some space between the arrow and the circle image
                    // Circle image
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: widget.clientAvatar != null
                              ? NetworkImage(widget.clientAvatar!)
                              : AssetImage("assets/images/lisa.png") as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16), // Add some space between the circle image and the text
                    // Text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.clientName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: "Caladea",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/fr.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Sub Text',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontFamily: "Caladea",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(), // Pushes the icon to the rightmost position
                    // Icons
                    SizedBox(width: 16),
                    Icon(Icons.error_outline, color: Colors.white),
                    SizedBox(width: 6),
                    Image.asset('assets/images/message_1.png', color: Colors.white),
                    SizedBox(width: 10),
                    Icon(Icons.more_vert, color: Colors.white),
                    // Add some space after the icon
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
          SizedBox(height: 627),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 94,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, -1), // Shadow position
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Button
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF262626),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    // Text Field
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Write your message',
                              hintStyle: TextStyle(color: Color(0xFFC4C4C4), fontSize: 16, fontFamily: "Caladea"),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    // Voice Icon
                    Icon(Icons.mic, color: Colors.black),
                    SizedBox(width: 8),
                    // Send Icon
                    Icon(Icons.send, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
