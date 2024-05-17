import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/response/api_response.dart';
import '../../../../api/response/status.dart';
import '../../../../api/view_model/inbox_view_model.dart';
import '../../../../model/conversation.dart';
import '../../../widgets/custom_error_widget.dart';
import '../../../widgets/inbox/inbox_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../profile/interface_userprofile.dart';


class InboxTabView extends StatefulWidget {
  const InboxTabView ({Key? key}) : super(key: key);

  @override
  State<InboxTabView> createState() => _InboxTabViewState();
}

class _InboxTabViewState extends State<InboxTabView>
    with AutomaticKeepAliveClientMixin<InboxTabView> {
  bool get wantKeepAlive => true;
  bool _isSearchBarVisible = false;
  bool _isFIlterBarVisible = false;
  String? userPhoto;
  late Size size ;
  late List<Inbox> filteredLines;
  late List<Inbox> allLines;
  // API
  InboxViewModel inboxViewModel = InboxViewModel();

  // UI
  final ScrollController _scrollController = ScrollController();

  // METHODS

  Future<void> loadData({bool withoutLoading = false}) async {
    await inboxViewModel.getAll(withoutLoading: withoutLoading);
    setState(() {
      allLines = inboxViewModel.itemList; // Populate allLines
      filteredLines = allLines; // Initially display all items
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update size when dependencies change
    size = MediaQuery.of(context).size;
  }
  @override
  void initState() {
    super.initState();
    filteredLines = [];
    allLines = [];
    fetchUserData();
    loadData();

  }
  void fetchUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    userPhoto = sharedPreferences.getString(UserProfileAPI.userPhotoUrlKey);
    // Update the UI after fetching data
    setState(() {});
  }
  void updateFilteredConversations(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredLines = allLines;
      } else {
        filteredLines = allLines.where((inbox) {
          return inbox.conversations.any((conversation) =>
              conversation.client.name.toLowerCase().contains(query.toLowerCase()));
        }).toList();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure AutomaticKeepAliveClientMixin is applied correctly
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => loadData(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 18),
                height: _isSearchBarVisible ? 120 : 130,
                child: Column(
                  children: [
                    SizedBox(height: 46),
                    Row(
                      children: [
                        SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isFIlterBarVisible = false;
                              _isSearchBarVisible = !_isSearchBarVisible;
                            });
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _isSearchBarVisible ? Colors.black : Colors.white,
                                width: 1,
                              ),
                              color: Color(0x1AFFFFFF),
                            ),
                            child: Icon(
                              _isSearchBarVisible ? Icons.search : Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isSearchBarVisible = false;
                              _isFIlterBarVisible = !_isFIlterBarVisible;
                            });
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _isFIlterBarVisible ? Colors.black : Colors.white,
                                width: 1,
                              ),
                              color: Color(0x1AFFFFFF),
                            ),
                            child: Icon(
                              _isFIlterBarVisible ? Icons.filter_alt_outlined : Icons.filter_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Inbox",
                              style: TextStyle(
                                fontFamily: "Caladea",
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 45),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: userPhoto != null
                                  ? NetworkImage(userPhoto!) // Use stored photo URL if available
                                  : AssetImage("assets/images/lisa.png") as ImageProvider, // Cast AssetImage to ImageProvider
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                    SizedBox(height: 26),
                  ],
                ),
              ),
            ),
            if (_isSearchBarVisible)
              Container(
                height: 85,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 16),
                        Expanded(
                          flex: 9,
                          child: Padding(
                            padding: EdgeInsets.only(right: 25, left: 14),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.black, fontFamily: "Caladea"),
                                onChanged: (value) {
                                  updateFilteredConversations(value);
                                },
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Caladea",
                                  ),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isSearchBarVisible = false;
                                      });
                                    },
                                    icon: Icon(Icons.search, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            if (_isFIlterBarVisible)
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 16),
                        Expanded(
                          flex: 9,
                          child: Padding(
                            padding: EdgeInsets.only(right: 25, left: 14),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.black, fontFamily: "Caladea"),
                                onChanged: updateFilteredConversations,
                                decoration: InputDecoration(
                                  hintText: "Assigned to",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Caladea",
                                  ),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isSearchBarVisible = false;
                                      });
                                    },
                                    icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        SizedBox(width: 16),
                        Expanded(
                          flex: 9,
                          child: Padding(
                            padding: EdgeInsets.only(right: 25, left: 14),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.black, fontFamily: "Caladea"),
                                onChanged: updateFilteredConversations,
                                decoration: InputDecoration(
                                  hintText: "Channel",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Caladea",
                                  ),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isSearchBarVisible = false;
                                      });
                                    },
                                    icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        SizedBox(width: 16),
                        Expanded(
                          flex: 9,
                          child: Padding(
                            padding: EdgeInsets.only(right: 25, left: 14),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.black, fontFamily: "Caladea"),
                                onChanged: updateFilteredConversations,
                                decoration: InputDecoration(
                                  hintText: "tag",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Caladea",
                                  ),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isSearchBarVisible = false;
                                      });
                                    },
                                    icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                    children: [
                      SizedBox(width: 265),
                     Positioned(
                      top: 0.0,
                      left: 0.0,
                      child: GestureDetector(
                        onTap: () {
                         // Navigator.pop(context); // Navigate back to the previous screen
                        },
                        child: Image.asset(
                          'assets/images/buttonfilter.png', // Your image asset for the button
                          width: 40, // Adjust the width as needed
                          height: 40, // Adjust the height as needed
                        ),
                      ),
                    ),
                      SizedBox(width: 9),
                    Container(
                      width: 69.0, // Set your desired width
                      height: 40.0, // Set your desired height
                      child: ElevatedButton(
                        onPressed: () {

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
                                'Filter',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Caladea',
                                  color: Colors.black, // Set your desired text color
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    ],
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),

            SizedBox(height: 20),
            Expanded(
              child: ChangeNotifierProvider(
                create: (context) => inboxViewModel,
                child: Consumer<InboxViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.apiResponse.status == Status.completed) {
                      return viewModel.itemList.isEmpty
                          ? Center(
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
                      )
                          : Scrollbar(
                        controller: _scrollController,
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          itemCount: filteredLines.length,
                          itemBuilder: (context, index) {
                            final inbox = filteredLines[index];
                            return InboxWidget(inbox: inbox);
                          },
                        ),
                      );
                    } else if (viewModel.apiResponse.status == Status.loading) {
                      return const LoadingWidget();
                    } else {
                      return CustomErrorWidget(tapFunction: () => loadData());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}