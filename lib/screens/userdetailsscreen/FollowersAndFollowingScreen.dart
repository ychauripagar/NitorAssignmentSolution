import 'package:flutter/material.dart';
import 'package:nitorassignmentsolution/common/AppMethods.dart';
import 'package:nitorassignmentsolution/providers/UserDetailsProvider.dart';
import 'package:nitorassignmentsolution/providers/UsersProvider.dart';
import 'package:nitorassignmentsolution/screens/usersscreen/UserItemWidget.dart';

import 'UserDetailsScreen.dart';

///Display followers & Following in Tab.
class FollowersAndFollowingScreen extends StatefulWidget {
  static const routeName = '/users';
  final List<UserItem> _followersUserItem;
  final List<UserItem> _followingsUserItem;
  final UserDetailsItem _userDetailsItem;
  final int tabIndex;

  FollowersAndFollowingScreen(this._followersUserItem, this._followingsUserItem,
      this._userDetailsItem, this.tabIndex);

  @override
  _FollowersAndFollowingScreenState createState() =>
      _FollowersAndFollowingScreenState();
}

class _FollowersAndFollowingScreenState
    extends State<FollowersAndFollowingScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;
  bool isFollowers = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
    _currentIndex = widget.tabIndex;
    _tabController.index = widget.tabIndex;
  }

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
      print("_currentIndex:::$_currentIndex");

      //Deposit Alerts
      if (_currentIndex == 0) {
        isFollowers = true;
      } else {
        isFollowers = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('getting followers and following');

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(
            child: Text(
              widget._userDetailsItem.name,
              style: TextStyle(
                fontFamily: 'Loto',
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              AppMethods.openScreen(
                  context, UserDetailsScreen(widget._userDetailsItem), false);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.purple,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                //loans tab
                Tab(
                  text: "Followers",
                ), //deposits tabs
                Tab(
                  text: "Following",
                ),
              ],
            ),
            Expanded(
              child: isFollowers
                  ? ListView.builder(
                      primary: false,
                      itemCount: widget._followersUserItem.length,
                      itemBuilder: (ctx, i) =>
                          UserItemWidget(widget._followersUserItem[i], false))
                  : ListView.builder(
                      primary: false,
                      itemCount: widget._followingsUserItem.length,
                      itemBuilder: (ctx, i) =>
                          UserItemWidget(widget._followingsUserItem[i], false)),
            )
          ],
        ));
  }
}
