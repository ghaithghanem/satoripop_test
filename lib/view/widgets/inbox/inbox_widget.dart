import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slideable/slideable.dart';

import '../../../api/repository/message_repository.dart';
import '../../../api/response/status.dart';
import '../../../api/view_model/conversation_msg_view_model.dart';
import '../../../api/view_model/inbox_view_model.dart';
import '../../../api/view_model/message_view_model.dart';
import '../../../model/conversation.dart';
import '../../../utils/api_view_handler.dart';
import '../../home/navebotton_screens/profile/interface_userprofile.dart';
import '../../message/message_screen.dart';
import '../loading_widget.dart';

class InboxWidget extends StatefulWidget {
  final Inbox inbox; // Change the type to Inbox

  InboxWidget({
    Key? key,
    required this.inbox,
  }) : super(key: key){}

  @override
  State<InboxWidget> createState() => _InboxWidgetState();
}

class _InboxWidgetState extends State<InboxWidget> {
 // MessageViewModel messageViewModel = MessageViewModel();
  ConversatioMsgViewModel conversatioMsgViewModel = ConversatioMsgViewModel();
  InboxViewModel inboxViewModel= InboxViewModel();
  bool _isArchiving = false;

  String? userPhoto;

  @override
  void initState() {
    super.initState();

    fetchUserData();
  }


  void fetchUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    userPhoto = sharedPreferences.getString(UserProfileAPI.userPhotoUrlKey);

    setState(() {});
  }

  void handleCustomAction2(int conversationId) {
    setState(() {
      _isArchiving = true;
    });
    inboxViewModel.archiveConversation(conversationId).then((_) {
      setState(() {
        _isArchiving = false;
      });
    });
  }
  void handleCustomAction1(int conversationId) {
    setState(() {
      _isArchiving = true;
    });
    inboxViewModel.deleteConversation(conversationId).then((_) {
      setState(() {
        _isArchiving = false;
      });
    });
  }

  /*void fetchDataMessage(int contactId) {
    ApiViewHandler.handleApiCallWithAlert(
      context: context,
      apiCall: () => conversatioMsgViewModel.getAllConvMessage(contactId),
      successFunction: () async {

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MessageScreen()),
              (Route<dynamic> route) => false,
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {

    List<Widget> conversationWidgets = [];



    for (var conversation in widget.inbox.conversations) {
      conversationWidgets.add(
        Slidable(
          key: ValueKey(conversation.id),

          endActionPane:  ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                flex: 1,
              onPressed:(BuildContext context){
                handleCustomAction2(conversation.id);
              },
                backgroundColor: Color(0xFFF6F6F6),
                foregroundColor: Colors.black,
                icon: Icons.archive_outlined,
                //label: 'Archive',
              ),
              SlidableAction(
                onPressed:(BuildContext context){
                  _showLogoutConfirmationDialog(conversation.id);
                },
                backgroundColor: Color(0xFFF6F6F6),
                foregroundColor: Color(0xFFFE4A49),
                icon: Icons.delete,
                //label: 'Delete',

              ),
            ],

          ),

          child:InkWell(
            onTap: () {
              var contactId = conversation.id;
              print("Clicked on conversation with id: ${contactId}");
              //fetchDataMessage(contactId);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MessageScreen(
                  clientName: conversation.client.name,
                  clientAvatar: conversation.client.avatarUrl,
                )),
                    (Route<dynamic> route) => false,
              );
            },
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundImage: conversation.client.avatarUrl != null
                                  ? NetworkImage(conversation.client.avatarUrl!)
                                  : AssetImage('assets/images/inboximage.png') as ImageProvider,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              //left: 10,
                              child: Container(
                                width: 20,
                                height: 20,
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/images/msgicon.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(width: 5),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          conversation.client.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Caladea',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          conversation.lastMessage.content,
                          maxLines: 1, // Display only one line
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Caladea',
                            color: Color(0xFF797C7B),
                          ),
                        ),
                        SizedBox(width: 14),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          conversation.lastMessage.date,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Caladea',
                            color: Color(0xFF797C7B),
                          ),
                        ),
                        SizedBox(height: 4),
                        if (conversation.lastMessage.status == 'SEEN')
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: userPhoto != null
                                    ? NetworkImage(userPhoto!)
                                    : AssetImage("assets/images/inboximage.png") as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: 14),
                ],
              ),
            ),
          ),

        ),

      );
    }

    // Return the list of ListTile widgets
    return Column(
      children: [
        if (_isArchiving) LoadingWidget(),
        ...conversationWidgets,
      ],

    );
  }
  void _showLogoutConfirmationDialog(int conversationId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.orange),
              SizedBox(width: 12),
              Text(
                'Are you sure ? ',
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
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 30),
              Text(
                  "Do you really want to delete\n this message.",
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
                handleCustomAction1(conversationId);
                Navigator.of(context).pop(); // Close the dialog after action
              },
              child: Text(
                'Yes, delete',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Caladea',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
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


}